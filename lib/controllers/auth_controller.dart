import 'package:donation_com_mm_v2/models/login_response.dart';
import 'package:donation_com_mm_v2/models/register_response.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  List<dynamic>? data;

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  final BaseClient _baseClient = BaseClient();

  login(
    String phone, String password, BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.signInUrl, // url
      RequestType.post,
      queryParameters: {"password":password,"phone":phone},
      onLoading: () {

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        MySharedPref.setUserName(loginResponse.user.name);
          MySharedPref.setToken(loginResponse.token);
        MySharedPref.setUserId(loginResponse.user.id);
        ToastHelper.showSuccessToast(context, "Successfully logined as ${loginResponse.user.name}");
        Get.offAllNamed(Routes.main);
        apiCallStatus = ApiCallStatus.success;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        update();
        // show error message to user
        if (error.response!.statusCode == 422) {
          // Handle 422 Unprocessable Entity error
          Map<String, dynamic>? errorDetails =
              error.response!.data as Map<String, dynamic>?;

          if (errorDetails != null) {
            // Extract and handle email error if present
            List<dynamic>? emailErrors =
                errorDetails['email'] as List<dynamic>?;

            if (emailErrors != null && emailErrors.isNotEmpty) {
              String emailErrorMessage = emailErrors.first;
              // Show the error message to the user
              apiCallStatus = ApiCallStatus.error;
              ToastHelper.showErrorToast(context, emailErrorMessage);
              return; // Return to avoid showing the generic error message below
            }
          }
          apiCallStatus = ApiCallStatus.holding;
          // Show a generic error message in case the email error is not present
          ToastHelper.showErrorToast(
              context, "An error occurred during sign up.");
        } else {
          // Handle other types of errors
          // Show a generic error message for other status codes
          apiCallStatus = ApiCallStatus.holding;
          ToastHelper.showErrorToast(
              context, "An unexpected error occurred during sign up.");
        }
        // *) indicate error status
        apiCallStatus = ApiCallStatus.holding;
        update();
      },
    );
  }


  register(
      String name, String phone, String password, BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.signUpUrl, // url
      RequestType.post,
      queryParameters: {"name": name, "phone": phone, "password": password},
      onLoading: () {

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        RegisterResponse registerResponse = RegisterResponse.fromJson(response.data);
        MySharedPref.setUserName(registerResponse.user.name);
               MySharedPref.setToken(registerResponse.token);
      
        MySharedPref.setUserId(registerResponse.user.id);
        ToastHelper.showSuccessToast(context, "Successfully created an account");
        Get.offAllNamed(Routes.main);
        apiCallStatus = ApiCallStatus.success;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        print(error.response!.data["message"]);
      ToastHelper.showErrorToast(context,error.response!.data["message"]);
        update();
      },
    );
  }

  logout(BuildContext context) async {
    // *) perform api call
    await _baseClient.safeApiCall(
      AppConfig.logOutUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },
      onLoading: () {
        // *) indicate loading state

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        // api done successfully
        MySharedPref.clear();

        Get.offAllNamed(Routes.login);

        ToastHelper.showSuccessToast(context, "Succesfully logout");

        // Get.offNamed(Routes.LOGIN);
        // *) indicate success state
        apiCallStatus = ApiCallStatus.success;

        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(apiException: error);

        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }
}
