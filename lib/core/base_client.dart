import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/util/string_enum.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';

import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import 'api_exception.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class BaseClient {
  final Dio _dio;

  BaseClient() : _dio = _createDioInstance();

  static Dio _createDioInstance() {
    final Dio dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _addLoggerInterceptor(dio);
    // _addCacheInterceptor(dio);

    return dio;
  }

  static void _addLoggerInterceptor(Dio dio) {
    final loggerInterceptor = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
    dio.interceptors.add(loggerInterceptor);
  }

  // static void _addCacheInterceptor(Dio dio) {
  //   final cacheInterceptor = DioCacheInterceptor(
  //     options: CacheOptions(
  //       store:
  //           HiveCacheStore(AppCachePathProvider.path, hiveBoxName: "go_pozt"),
  //       policy: CachePolicy.refresh,
  //       hitCacheOnErrorExcept: [401, 404],
  //       maxStale: const Duration(minutes: 5),
  //       keyBuilder: (request) {
  //         return request.uri.toString();
  //       },
  //       allowPostMethod: false,
  //       priority: CachePriority.high,
  //     ),
  //   );
  //   dio.interceptors.add(cacheInterceptor);
  // }

  // request timeout (default 10 seconds)
  static const int _timeoutInSeconds = 10;

  /// dio getter (used for testing)
  // static get dio => _dio;

  /// perform safe api request
  Future<void> safeApiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)?
        onSendProgress, // while sending (uploading) progress
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      await onLoading?.call();
      // 2) try to perform http request
      late Response response;
      if (requestType == RequestType.get) {
        response = await _dio.get(
          url,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
      } else if (requestType == RequestType.post) {
        response = await _dio.post(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.put) {
        response = await _dio.put(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else {
        response = await _dio.delete(
          url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      }
      // 3) return response (api done successfully)
      await onSuccess(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      _handleDioError(
        error: error,
        url: url,
        onError: onError,
      );
    } on SocketException {
      // No internet connection
      _handleSocketException(
        url: url,
        onError: onError,
      );
    } on TimeoutException {
      // Api call went out of time
      _handleTimeoutException(
        url: url,
        onError: onError,
      );
    } catch (error) {
      // print the line of code that throw unexpected exception
      Logger().e(error);
      // unexpected error for example (parsing json error)
      _handleUnexpectedException(
        url: url,
        onError: onError,
        error: error,
      );
    }
  }

  // /// download file
  // static download({
  //   required String url, // file url
  //   required String savePath, // where to save file
  //   Function(ApiException)? onError,
  //   Function(int value, int progress)? onReceiveProgress,
  //   required Function onSuccess,
  // }) async {
  //   try {
  //     await _dio.download(
  //       url,
  //       savePath,
  //       options: Options(
  //           receiveTimeout: const Duration(seconds: _timeoutInSeconds),
  //           sendTimeout: const Duration(seconds: _timeoutInSeconds)),
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     onSuccess();
  //   } catch (error) {
  //     var exception = ApiException(url: url, message: error.toString());
  //     onError?.call(exception) ??
  //         _handleError(
  //           error.toString(),
  //         );
  //   }
  // }

  /// handle unexpected error
  static _handleUnexpectedException({
    Function(ApiException)? onError,
    required String url,
    required Object error,
  }) {
    if (onError != null) {
      onError(ApiException(
        message: error.toString(),
        url: url,
      ));
    } else {
      _handleError(
        error.toString(),
      );
    }
  }

  /// handle timeout exception
  static _handleTimeoutException({
    Function(ApiException)? onError,
    required String url,
  }) {
    if (onError != null) {
      onError(ApiException(
        message: Strings.serverNotResponding,
        url: url,
      ));
    } else {
      _handleError(
        Strings.serverNotResponding,
      );
    }
  }

  /// handle timeout exception
  static _handleSocketException({
    Function(ApiException)? onError,
    required String url,
  }) {
    if (onError != null) {
      onError(ApiException(
        message: Strings.noInternetConnection,
        url: url,
      ));
    } else {
      _handleError(
        Strings.noInternetConnection,
      );
    }
  }

  /// handle Dio error
  static _handleDioError({
    required DioException error,
    Function(ApiException)? onError,
    required String url,
  }) {
    // 404 error
    if (error.response?.statusCode == 404) {
      if (onError != null) {
        return onError(ApiException(
          message: Strings.urlNotFound,
          url: url,
          statusCode: 404,
        ));
      } else {
        return _handleError(
          Strings.urlNotFound,
        );
      }
    }

    // no internet connection
    if (error.message != null &&
        error.message!.toLowerCase().contains('socket')) {
      if (onError != null) {
        return onError(ApiException(
          message: Strings.noInternetConnection,
          url: url,
        ));
      } else {
        return _handleError(
          Strings.noInternetConnection,
        );
      }
    }

    // check if the error is 500 (server problem)
    if (error.response?.statusCode == 500) {
      var exception = ApiException(
        message: Strings.serverError,
        url: url,
        statusCode: 500,
      );

      if (onError != null) {
        return onError(exception);
      } else {
        return handleApiError(
          apiException: exception,
        );
      }
    }

    var exception = ApiException(
        url: url,
        message: error.message ?? 'Un Expected Api Error!',
        response: error.response,
        statusCode: error.response?.statusCode);
    if (onError != null) {
      return onError(
        exception,
      );
    } else {
      return handleApiError(
        apiException: exception,
      );
    }
  }

  /// handle error automaticly (if user didnt pass onError) method
  /// it will try to show the message from api if there is no message
  /// from api it will show the reason (the dio message)
  static void handleApiError({
    required ApiException apiException,
    BuildContext? context,
  }) {
    String message = "";

    try {
      if (apiException.response != null) {
        final responseData = apiException.response!.data;

        if (responseData != null && responseData.containsKey("errors")) {
          final errors = responseData["errors"];

          if (errors is Map<String, dynamic>) {
            List<String> validationErrors = [];

            errors.forEach((key, value) {
              if (value is List) {
                validationErrors.addAll(value.map((error) => error.toString()));
              } else {
                validationErrors.add(value.toString());
              }
            });

            if (validationErrors.isNotEmpty) {
              // Join all validation errors into a single message
              message = validationErrors.join(", ");
            } else {
              // Set a default message for validation errors
              message = "Validation error";
            }
          } else {
            // Handle unexpected error structure
            message = "Something went wrong";
          }
        } else if (responseData != null &&
            responseData.containsKey("message")) {
          // Handle other types of errors with a 'message' key
          message = responseData["message"];
        } else {
          // Handle other types of errors
          message = "An error occurred";
        }
      } else {
        // Handle Dio-specific errors
        message = "An unexpected error occurred.Try again later.";
      }
    } catch (error) {
      // Handle unexpected exceptions or errors
      message = "An unexpected error occurred";
      Logger().e(error.toString());
    }

    if (context != null) {
      ToastHelper.showErrorToast(context, message);
    } else {
      // Show a toast or handle differently in non-UI context
      // Fluttertoast.showToast(msg: message);
    }
  }

  static void handleAuthError(ApiException apiException) {
    String msg = apiException.response!.data?["message"]?.toString() ??
        "An error occurred"; // Provide a default message if response["message"] is not available.

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT, // Specify toast length (short or long).
      gravity:
          ToastGravity.BOTTOM_RIGHT, // Specify toast gravity (e.g., CENTER).
      timeInSecForIosWeb: 2, // Specify duration on iOS and web platforms.
      backgroundColor: Colors.red, // Specify background color.
      textColor: Colors.white, // Specify text color.
      fontSize: 16.0, // Specify font size.
    );
  }

  /// handle errors without response (500, out of time, no internet,..etc)
  static _handleError(
    String msg,
  ) {
    Fluttertoast.showToast(msg: msg);
  }
}
