import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../models/item_response.dart';


class EditNatebanzayController extends GetxController{



  final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();
final HomeController _homeController=Get.find();
      final RxList<Item> _items = RxList.empty();
  List<Item> get items => _items.toList();
final Rx<Item> _selectedItem=Item(
    id: 0,
    name: "အမျိုးအစားရွေးပါ",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ).obs;
  Item get selectedItem => _selectedItem.value;

final RxList<File> _pickedPhotos=RxList.empty();
List<File> get pickedPhotos=> _pickedPhotos.toList();
  editNatebanzay(
    int id,
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



  if (pickedPhotos.isNotEmpty) {
  for (int i = 0; i < pickedPhotos.length; i++) {
    File imageFile = pickedPhotos[i];
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
      "${AppConfig.editNatebanzayUrl}/$id", // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data:formData,
      onLoading: () {

        _apiCallStatus.value = ApiCallStatus.loading;
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;
     
      },
      
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value=ApiCallStatus.success;

        _homeController.getNatebanzays();
        _homeController.getNatebanzaysRequested();

        ToastHelper.showSuccessToast(context,"အလှူကိုအောင်မြင်စွာပြင်ဆင်ပီးပါပီ");

      },

      onError: (error) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.error;
  
    
      },
    );
  }


  void pickPhotos() async {
    final List<XFile> pickedFiles = await ImagePicker().pickMultiImage(

    );
List<File> imageFiles =
          pickedFiles.map((image) => File(image.path)).toList();
          _pickedPhotos.value=imageFiles;
          print("picked files $pickedPhotos");

          print("PHotos $pickedPhotos");
update();
  
    }


  void setItem(Item item){
    _selectedItem.value=item;
  }


  Future<void> getItems() async {
    await _baseClient.safeApiCall(
      AppConfig.itemsUrl, // url
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

        ItemResponse itemResponse = ItemResponse.fromJson(response.data);
        _items.value = itemResponse.data;
     
      },
      

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
       
      },
    );
  }



}