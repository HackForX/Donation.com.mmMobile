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

  final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus  get apiCallStatus => _apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();

  login(
    String phone, String password, BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.signInUrl, // url
      RequestType.post,
      queryParameters: {"password":password,"phone":phone},
      onLoading: () {

        _apiCallStatus.value = ApiCallStatus.loading;
     
      },
      onSuccess: (response) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        MySharedPref.setUserName(loginResponse.user.name);
          MySharedPref.setToken(loginResponse.token);
        MySharedPref.setUserId(loginResponse.user.id);
        ToastHelper.showSuccessToast(context, "Successfully logined as ${loginResponse.user.name}");
        Get.offAllNamed(Routes.main);
        _apiCallStatus.value= ApiCallStatus.success;
      
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        
      ToastHelper.showErrorToast(context,error.response!.data["message"]);
      }
    );
  }


  register(
      String name, String phone, String password, BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.signUpUrl, // url
      RequestType.post,
      queryParameters: {"name": name, "phone": phone, "password": password},
      onLoading: () {

       _apiCallStatus.value = ApiCallStatus.loading;
  
      },
      onSuccess: (response) {
        RegisterResponse registerResponse = RegisterResponse.fromJson(response.data);
        MySharedPref.setUserName(registerResponse.user.name);
               MySharedPref.setToken(registerResponse.token);
      
        MySharedPref.setUserId(registerResponse.user.id);
        ToastHelper.showSuccessToast(context, "Successfully created an account");
        Get.offAllNamed(Routes.main);
        _apiCallStatus.value = ApiCallStatus.success;
  
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
  
      ToastHelper.showErrorToast(context,error.response!.data["message"]);
  
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

        _apiCallStatus.value = ApiCallStatus.loading;
       
      },
      onSuccess: (response) {
        // api done successfully
        MySharedPref.clear();

        Get.offAllNamed(Routes.login);

        ToastHelper.showSuccessToast(context, "Succesfully logout");

        // Get.offNamed(Routes.LOGIN);
        // *) indicate success state
        _apiCallStatus.value = ApiCallStatus.success;

        
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(apiException: error);

        // *) indicate error status
        _apiCallStatus.value = ApiCallStatus.error;
     
      },
    );
  }

  saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }
}
