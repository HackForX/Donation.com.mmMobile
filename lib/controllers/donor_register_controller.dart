import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:permission_handler/permission_handler.dart';


class DonorRegisterController extends GetxController{



  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  final BaseClient _baseClient = BaseClient();

  File? pickedFrontNrc;
  File? pickedBackNrc;


  register(
      String name,String address, String phone,String business,String position,String documentNumber,BuildContext context) async {
        print("Document Number $documentNumber");
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
        "document": pickedFrontNrc==null?null:await MultipartFile.fromFile(pickedFrontNrc!.path)

      
      }),
      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        apiCallStatus=ApiCallStatus.success;
         PanaraInfoDialog.showAnimatedGrow(
                  context, 
                  // title: "Donation.com.mm",
                  message: "အောင်မြင်စွာစာရင်းသွင်းပီးပါပီ",
                  buttonText: "Okay",
                  onTapDismiss: () {
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.success,
                );
        update();
      },

      onError: (error) {
        EasyLoading.dismiss();
         if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
        apiCallStatus = ApiCallStatus.error;
  
        update();
      },
    );
  }


  // void pickFrontNrc() async {
  //   final XFile? pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //   );
  //   if (pickedFile != null) {
  //     pickedFrontNrc = File(pickedFile.path);
  //     update(); // Refresh the UI
  //   }
  // }
Future<void> pickFrontNrc() async {
  try {
    // Request camera permission first
    final camera = await Permission.camera.request();
    
    if (camera.isGranted) {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // Reduced quality
        maxWidth: 800,    // Reduced size
        maxHeight: 800,
        preferredCameraDevice: CameraDevice.rear,
      );
      
      if (image != null) {
        pickedFrontNrc = File(image.path);
        update();
      }
    } else {
      _showPermissionDialog();
    }
  } catch (e) {
    debugPrint('Error picking front NRC image: $e');
    Get.snackbar(
      'Error',
      'Failed to capture image. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

Future<void> pickBackNrc() async {
  try {
    // Request camera permission first
    final camera = await Permission.camera.request();
    
    if (camera.isGranted) {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // Reduced quality
        maxWidth: 800,    // Reduced size
        maxHeight: 800,
        preferredCameraDevice: CameraDevice.rear,
      );
      
      if (image != null) {
        pickedBackNrc = File(image.path);
        update();
      }
    } else {
      _showPermissionDialog();
    }
  } catch (e) {
    debugPrint('Error picking back NRC image: $e');
    Get.snackbar(
      'Error',
      'Failed to capture image. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
void _showPermissionDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text('Permission Required'),
      content: const Text('Camera and Photos access is required to capture NRC photos. Please enable them in settings.'),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            await openAppSettings();
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
    // void pickBackNrc() async {
    // final XFile? pickedFile = await ImagePicker().pickImage(
    //   source: ImageSource.camera,
    // );
    // if (pickedFile != null) {
    //   pickedBackNrc = File(pickedFile.path);
    //   update(); // Refresh the UI
    // }
  // }

}