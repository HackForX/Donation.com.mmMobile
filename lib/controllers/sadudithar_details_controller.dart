import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/models/sadudithar_comment_response.dart';
import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
// import 'package:open_apps_settings_fork/open_apps_settings.dart';
// import 'package:open_apps_settings_fork/settings_enum.dart';


class SaduditharDetailsController extends GetxController{

    final RxList<SaduditharComment> _comments = RxList.empty();
  List<SaduditharComment> get comments => _comments.toList();
  final Rxn<Sadudithar> _sadudithar=Rxn<Sadudithar>();
  Sadudithar? get sadudithar=> _sadudithar.value;
  final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();
  final RxBool _isLike=RxBool(false);
  bool get isLike=>_isLike.value;

  Future<void>getDetails(int id) async{

    await _baseClient.safeApiCall(
      "${AppConfig.saduditharsUrl}/$id", // url
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

        Sadudithar sadudithar = Sadudithar.fromJson(response.data['data']);
        _sadudithar.value=sadudithar;
        

      },

      onError: (error) {
        EasyLoading.dismiss()
;        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }
  Future<void> getComments(int id) async {
    await _baseClient.safeApiCall(
      "${AppConfig.saduditharCommentsUrl}/$id", // url
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

        SaduditharCommentResponse commentResponse = SaduditharCommentResponse.fromJson(response.data);
        _comments.value = commentResponse.data;

      },

      onError: (error) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }


  comment(
      int saduditharId,int userId,String comment,BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.saduditharCommentsUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data: FormData.fromMap({

        "user_id": userId,
        'sadudithar_id':saduditharId,
        'comment':comment
        

      }),
      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        _apiCallStatus.value = ApiCallStatus.loading;
     
      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value=ApiCallStatus.success;
        getComments(saduditharId);
     EasyLoading.showSuccess("Commented");
       
      },

      onError: (error) {
        EasyLoading.dismiss();
        if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        if(error.statusCode==401){
          Get.toNamed(Routes.login);
        }
        _apiCallStatus.value = ApiCallStatus.error;
  
        update();
      },
    );
  }


  like(
      int saduditharId,BuildContext context) async {
    await _baseClient.safeApiCall(
      "${AppConfig.saduditharLikesUrl}/$saduditharId", // url
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
      
        getDetails(saduditharId);

      EasyLoading.showSuccess(response.data['message']);
       
      },

      onError: (error) {
        if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        if(error.statusCode==401){
          Get.toNamed(Routes.login);
        }
        _apiCallStatus.value = ApiCallStatus.error;
  
        update();
      },
    );
  }


  view(
      int saduditharId,BuildContext context) async {
    await _baseClient.safeApiCall(
      "${AppConfig.saduditharViewsUrl}/$saduditharId", // url
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
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        _apiCallStatus.value = ApiCallStatus.error;
  
        update();
      },
    );
  }



void openLocationSetting() async{
    // OpenAppsSettings.openAppsSettings(
    //                         settingsCode: SettingsCode.LOCATION,);

  
}



}