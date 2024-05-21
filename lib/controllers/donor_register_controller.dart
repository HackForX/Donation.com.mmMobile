import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';


class DonorRegisterController extends GetxController{



  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  final BaseClient _baseClient = BaseClient();

  File? pickedDocumentImage;

  register(
      String name,String address, String phone,String business,String position,int documentNumber,BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.registerDonorUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data: FormData.fromMap({
        "name": name,
        "address":address,
        "phone":phone,
        "position":position,
        "business":business,
        "document_number":documentNumber,
        "document": pickedDocumentImage==null?null:await MultipartFile.fromFile(pickedDocumentImage!.path)

      
      }),
      onLoading: () {

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus=ApiCallStatus.success;
        ToastHelper.showSuccessToast(context,response.data['message']);
        update();
      },

      onError: (error) {
         if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        apiCallStatus = ApiCallStatus.error;
  
        update();
      },
    );
  }


  void pickDiscussionImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      pickedDocumentImage = File(pickedFile.path);
      update(); // Refresh the UI
    }
  }

}