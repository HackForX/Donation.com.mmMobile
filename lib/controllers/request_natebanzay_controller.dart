import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../routes/app_pages.dart';


class RequestNatebanzayController extends GetxController{



  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  final BaseClient _baseClient = BaseClient();
  final HomeController _homeController=Get.find<HomeController>();



  request(
      int natebanzayId,BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.requestNatebanzayUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data: FormData.fromMap({
        "natebanzay_id": natebanzayId,
        

      
      }),
      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        apiCallStatus=ApiCallStatus.success;
        _homeController.getNatebanzaysRequests();
        EasyLoading.showSuccess("Requested Successfully");
        update();
      },

      onError: (error) {
        EasyLoading.dismiss();
        if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        if(error.statusCode==401){
          Get.toNamed(Routes.login) ;
        }
        apiCallStatus = ApiCallStatus.error;
  
        update();
      },
    );
  }




}