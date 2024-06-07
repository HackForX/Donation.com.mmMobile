import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/models/natebanzay_comment_response.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';
import '../util/app_config.dart';
import '../util/share_pref_helper.dart';
import '../util/toast_helper.dart';

class NatebanzayDetailsController extends GetxController{
  final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();
    final RxBool _isLike=RxBool(false);
  bool get isLike=>_isLike.value;

    final RxList<NatebanzayComment> _comments = RxList.empty();
  List<NatebanzayComment> get comments => _comments.toList();
  final Rxn<Natebanzay> _natebanzay=Rxn<Natebanzay>();
  Natebanzay? get natebanzay=> _natebanzay.value;



  Future<void>getDetails(int id) async{
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayUrl}/$id", // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        // _apiCallStatus.value = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        print("Natebanzay ${response.data}");
        _apiCallStatus.value = ApiCallStatus.success;

        Natebanzay natebanzay = Natebanzay.fromJson(response.data['data']);
        _natebanzay.value=natebanzay;
        

      },

      onError: (error) {
        EasyLoading.dismiss();
        print("Error $error");

        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }

  Future<void> getComments(int id) async {
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayCommentsUrl}/$id", // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        _apiCallStatus.value = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        _apiCallStatus.value = ApiCallStatus.success;

        NatebanzayCommentResponse commentResponse = NatebanzayCommentResponse.fromJson(response.data);
        _comments.value = commentResponse.data;

      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }


  comment(
      int natebanzayId,int userId,String comment,BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.natebanzayCommentsUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data: FormData.fromMap({

        "user_id": userId,
        'natebanzay_id':natebanzayId,
        'comment':comment
        

      }),
      onLoading: () {

        _apiCallStatus.value = ApiCallStatus.loading;
     
      },
      onSuccess: (response) {
        _apiCallStatus.value=ApiCallStatus.success;
        getComments(natebanzayId);
        ToastHelper.showSuccessToast(context,"Commented");
       
      },

      onError: (error) {
        print("erro ${error.toString()}");
        if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        _apiCallStatus.value = ApiCallStatus.error;
  
        update();
      },
    );
  }


  like(
      int natebanzayId) async {
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayLikesUrl}/$natebanzayId", // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

     
      onLoading: () {

        // _apiCallStatus.value = ApiCallStatus.loading;
        
     
      },
      onSuccess: (response) {
        _apiCallStatus.value=ApiCallStatus.success;
      
        getDetails(natebanzayId);
EasyLoading.showSuccess("${response.data['message']} ပေးပီးပါပီ");
       
      },

      onError: (error) {
        if(error.statusCode==422){
        // ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        _apiCallStatus.value = ApiCallStatus.error;
  
        update();
      },
    );
  }


  view(
      int natebanzayId) async {
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayViewsUrl}/$natebanzayId", // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

     
      onLoading: () {

        _apiCallStatus.value = ApiCallStatus.loading;
     
      },
      onSuccess: (response) {
        _apiCallStatus.value=ApiCallStatus.success;

     
       
      },

      onError: (error) {
        if(error.statusCode==422){
        // ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        _apiCallStatus.value = ApiCallStatus.error;
  
        update();
      },
    );
  }

}