import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/models/natebanzay_request_from_natebanzay_model.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class NatebanzayRequestController extends GetxController{
       final RxList<NatebanzayRequestFromNatebanzay> _natebanzaysRequests = RxList.empty();
  List<NatebanzayRequestFromNatebanzay> get natebanzaysRequests => _natebanzaysRequests.toList();
  final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();
  Future<void> getRequests(int id) async {
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayUrl}/$id/requests", // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        _apiCallStatus.value = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.success;

        NatebanzayRequestFromNatebanzayResponse natebanzayRequestResponse = NatebanzayRequestFromNatebanzayResponse.fromJson(response.data);
        _natebanzaysRequests.value = natebanzayRequestResponse.data;

      },

      onError: (error) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }

   Future<void> acceptRequest(int id,BuildContext context) async {
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayRequestsUrl}/$id/accept", // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        _apiCallStatus.value = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.success;
            getRequests(id);
        ToastHelper.showSuccessToast(context,response.data['message'],);

  

      },

      onError: (error) {
        EasyLoading.dismiss();
         if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
         }
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }


   Future<void> rejectRequest(int id,BuildContext context) async {
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayRequestsUrl}/$id/reject", // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        _apiCallStatus.value = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.success;
        ToastHelper.showSuccessToast(context,response.data['message'],);

      getRequests(id);

      },

      onError: (error) {
        EasyLoading.dismiss();
         if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
         }
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }




}