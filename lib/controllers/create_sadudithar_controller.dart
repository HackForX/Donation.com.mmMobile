
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/models/category_response.dart';
import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../models/city_response.dart';
import '../models/township_response.dart';


class CreateSaduditharController extends GetxController{


  final Rx<ApiCallStatus> _apiCallStatus = Rx<ApiCallStatus>(ApiCallStatus.holding);
ApiCallStatus get apiCallStatus => _apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();
        final RxList<SaduditharCategory> _categories = RxList.empty();
  List<SaduditharCategory> get categories => _categories.toList();
        final RxList<SaduditharCity> _cities = RxList.empty();
  List<SaduditharCity> get cities => _cities.toList();
       final RxList<Township> _townships = RxList.empty();
  List<Township> get townships => _townships.toList();

    final Rx<SaduditharCategory> _selectedCategory=SaduditharCategory(
    id: 0,
    name: "အမျိုးအစားရွေးပါ",
    type: "",
    subCategories: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ).obs;

  SaduditharCategory get selectedCategory => _selectedCategory.value;

    final Rx<SubCategory> _selectedSubCategory=SubCategory(
    id: 0,
    name: "အမျိုးအစားခွဲရွေးပါ",
    type: "",
    categoryId: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ).obs;

  SubCategory get selectedSubCategory => _selectedSubCategory.value;

    final Rx<SaduditharCity> _selectedCity=SaduditharCity(
    id: 0,
    name: "မြို့ရွေးပါ",



  isActive: 1,
  townships: [],
    createdAt:"",
    updatedAt:""
  ).obs;
  SaduditharCity get selectedCity=>_selectedCity.value;
      final Rx<Township> _selectedTownship=Township(
    id: 0,
    name: "မြို့နယ်ရွေးပါ",


cityId: 1,
cityName: "",
  isActive: 1,

    createdAt:"",
    updatedAt:""
  ).obs;
  Township get selectedTownship=>_selectedTownship.value;
  final RxString _selectedEndTime=RxString("ပြီးဆုံးမည့်အချိန်");
  String get selectedEndTime=> _selectedEndTime.value;
  final RxString _selectedStartTime=RxString("စတင်မည့်အချိန်");
  String get selectedStartTime=> _selectedStartTime.value;
   final RxString _eventDate=RxString("နေ့ရက်");
  String get eventDate=> _eventDate.value;
  File? pickedImage;

  

  createSadudithar(
      CreateSaduditharModel createSaduditharModel,BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.saduditharsUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data: FormData.fromMap({
        "title":createSaduditharModel.title,
        "description":createSaduditharModel.description,
        "category_id":createSaduditharModel.categoryId,
        "city_id":createSaduditharModel.cityId,
        "township_id":createSaduditharModel.townshipId,
        "subCategory_id":createSaduditharModel.subCategoryId,
        "user_id":MySharedPref.getUserId(),
        "estimated_amount":createSaduditharModel.estimatedAmount,
        "estimated_time":createSaduditharModel.estimatedTime,
        "estimated_quantity":createSaduditharModel.estimatedQuantity,
        "actual_start_time":createSaduditharModel.actualStartTime,
        "actual_end_time":createSaduditharModel.actualEndTime,
        "address":createSaduditharModel.address,
        "phone":createSaduditharModel.phone,
        "status":createSaduditharModel.status,
        "event_date":createSaduditharModel.eventDate,
        "longitude":createSaduditharModel.longitude,
        "latitude":createSaduditharModel.latitude,
                "image": pickedImage==null?null:await MultipartFile.fromFile(pickedImage!.path),
                "is_open":1,
                "is_show":0
      }),
      onLoading: () {

       _apiCallStatus.value= ApiCallStatus.loading;
        
      },
      onSuccess: (response) {
        _apiCallStatus.value=ApiCallStatus.success;
        ToastHelper.showSuccessToast(context,"အောင်မြင်ပါသည်");
        
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
  
        update();
      },
    );
  }



  Future<void> getCategories() async {
    await _baseClient.safeApiCall(
      AppConfig.categoriesUrl, // url
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

        CategoryResponse categoryResponse = CategoryResponse.fromJson(response.data);
        _categories.value = categoryResponse.data;

      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
   
      },
    );
  }



  Future<void> getCities() async {
    await _baseClient.safeApiCall(
      AppConfig.citiesUrl, // url
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

        CityResponse cityResponse = CityResponse.fromJson(response.data);
        _cities.value = cityResponse.data;
    
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        
      },
    );
  }


  Future<void> getTownships() async {
    await _baseClient.safeApiCall(
      AppConfig.townshipsUrl, // url
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

        TownshipResponse townshipResponse = TownshipResponse.fromJson(response.data);
        _townships.value = townshipResponse.data;
   
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);

      },
    );
  }




  void pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      update(); // Refresh the UI
    }
  }


  void setCategory(SaduditharCategory category){
    _selectedCategory.value=category;
  }


  void setCity(SaduditharCity city){
    _selectedCity.value=city;
  }

    void setTownship(Township township){
    _selectedTownship.value=township;
  }

    void setSubCategory(SubCategory subCategory){
    _selectedSubCategory.value=subCategory;
  }

  void setSelectedStartTime(String startTime){
    _selectedStartTime.value=startTime;
  }


   void setSelectedEndTime(String endTime){
    _selectedEndTime.value=endTime;
  }

     void setEventDate(String eventDate){
    _eventDate.value=eventDate;
  }









}

class CreateSaduditharModel{
  final String title;
  final String description;
  final int categoryId;
  final int cityId;
  final int townshipId;
  final int subCategoryId;

  final int estimatedAmount;
  final String estimatedTime;
  final String estimatedQuantity;
  final String actualStartTime;
  final String actualEndTime;
  final String address;
  final String phone;
  final String status;
  final String eventDate;
  final double latitude;
  final double longitude;
  

  CreateSaduditharModel({required this.title, required this.description,required this.categoryId, required this.cityId, required this.townshipId, required this.subCategoryId, required this.estimatedAmount, required this.estimatedTime, required this.estimatedQuantity, required this.actualStartTime, required this.actualEndTime, required this.address, required this.phone, required this.status, required this.eventDate,required this.latitude,required this.longitude});
}