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


class CreateNatebanzayController extends GetxController{



  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  final BaseClient _baseClient = BaseClient();

  List<File>? pickedPhotos;
  createNatebanzay(
      String name,String quantity,String address,int userId, int itemId,String phone, String status,String note,BuildContext context) async {
        var formData = FormData();

  // Add form data
  formData.fields.add(MapEntry('name', name));
  formData.fields.add(MapEntry('quantity', quantity.toString()));
  formData.fields.add(MapEntry('address', address));
  formData.fields.add(MapEntry('user_id', userId.toString()));
  formData.fields.add(MapEntry('phone', phone));
  formData.fields.add(MapEntry('status', status));
  formData.fields.add(MapEntry('note', note));
  formData.fields.add(MapEntry('item_id', itemId.toString()));



  if (pickedPhotos != null && pickedPhotos!.isNotEmpty) {
  for (int i = 0; i < pickedPhotos!.length; i++) {
    File imageFile = pickedPhotos![i];
    String fileName = imageFile.path.split('/').last;
    formData.files.add(MapEntry(
        'photos[]',
        await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        )));
  }
}
    await _baseClient.safeApiCall(
      AppConfig.createNatebanzayUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data:formData,
      onLoading: () {

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus=ApiCallStatus.success;
        ToastHelper.showSuccessToast(context,"အလှူကိုအောင်မြင်စွာတင်ပီးပါပီ");
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
  
        update();
      },
    );
  }


  void pickPhotos() async {
    final List<XFile> pickedFiles = await ImagePicker().pickMultiImage(

    );
List<File> imageFiles =
          pickedFiles.map((image) => File(image.path)).toList();
          pickedPhotos=imageFiles;

          print("PHotos $pickedPhotos");

    update(); // Refresh the UI
    }

}