
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/models/category_response.dart';
import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:open_apps_settings_fork/open_apps_settings.dart';
// import 'package:open_apps_settings_fork/settings_enum.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

// import 'package:location/location.dart';

import '../models/city_response.dart';
import '../models/township_response.dart';
import '../util/toast_helper.dart';


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

    final Rx<String> _selectedCategory=RxString("အမျိုးအစားရွေးပါ *");

  String get selectedCategory => _selectedCategory.value;

  final RxBool isLocationDisabled=RxBool(false);



    final Rx<SaduditharCategory> _selectedSubCategory=SaduditharCategory(
    id: 0,
    name: "အမျိုးအစားခွဲရွေးပါ *",
    type: "",
 
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ).obs;

  SaduditharCategory get selectedSubCategory => _selectedSubCategory.value;

    final Rx<SaduditharCity> _selectedCity=SaduditharCity(
    id: 0,
    name: "မြို့ရွေးပါ *",



  isActive: 1,
  townships: [],
    createdAt:"",
    updatedAt:""
  ).obs;
  SaduditharCity get selectedCity=>_selectedCity.value;
      final Rx<Township> _selectedTownship=Township(
    id: 0,
    name: "မြို့နယ်ရွေးပါ *",


cityId: 1,
cityName: "",
  isActive: 1,

    createdAt:"",
    updatedAt:""
  ).obs;
  Township get selectedTownship=>_selectedTownship.value;
  final  Rxn<DateTime> _selectedEndTime=Rxn<DateTime>();
  DateTime? get selectedEndTime=> _selectedEndTime.value;
  final Rxn<DateTime> _selectedStartTime=Rxn<DateTime>();
  DateTime? get selectedStartTime=> _selectedStartTime.value;
   final Rxn<DateTime> _eventDate=Rxn<DateTime>();
  DateTime? get eventDate=> _eventDate.value;
   final Rx<Position?> _currentPosition = Rx<Position?>(null);
   Position? get currentPositon => _currentPosition.value;
   final RxDouble _pickedLat=RxDouble(0.0);
   double get pickedLat => _pickedLat.value;
   final RxDouble _pickedLong=RxDouble(0.0);
   double get pickedLong => _pickedLong.value;
      final RxString _pickedAddress=RxString("မြေပုံ");
   String get pickedAddress => _pickedAddress.value;
  File? pickedImage;

  

  createSadudithar(
      CreateSaduditharModel createSaduditharModel,BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.saduditharsUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data: FormData.fromMap({
        "title":createSaduditharModel.title,
        "description":createSaduditharModel.description,
        "category_id":createSaduditharModel.categoryId,
        "city_id":createSaduditharModel.cityId,
        "township_id":createSaduditharModel.townshipId,
        "type":createSaduditharModel.type,
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
        "longitude":createSaduditharModel.longitude==0?null:createSaduditharModel.longitude,
        "latitude":createSaduditharModel.latitude==0?null:createSaduditharModel.latitude,
                "image": pickedImage==null?null:await MultipartFile.fromFile(pickedImage!.path,filename:pickedImage!.path.split("/").last ),
                "is_open":1,
                "is_show":0
      }),
      onLoading: () {

       _apiCallStatus.value= ApiCallStatus.loading;
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        
      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value=ApiCallStatus.success;
        Get.find<HomeController>().getSadudithars() ;
          PanaraInfoDialog.showAnimatedGrow(
                  context, 
                  // title: "Donation.com.mm",
                  message: "အလှူကိုအောင်မြင်စွာတင်ပီးပါပီ",
                  buttonText: "Okay",
                  onTapDismiss: () {
                    Navigator.pop(context);
                  },
                  panaraDialogType: PanaraDialogType.success,
                );

        
      },

      onError: (error) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.error;
            if(error.statusCode==422){
        ToastHelper.showErrorToast(context,error.response!.data["message"]);
          
        }
  
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


  void setCategory(String category){
    _selectedCategory.value=category;
  }


  void setCity(SaduditharCity city){
    _selectedCity.value=city;
  }

    void setTownship(Township township){
    _selectedTownship.value=township;
  }

    void setSubCategory(SaduditharCategory subCategory){
    _selectedSubCategory.value=subCategory;
  }

  void setSelectedStartTime(DateTime startTime){
    _selectedStartTime.value=startTime;
  }


   void setSelectedEndTime(DateTime endTime){
    _selectedEndTime.value=endTime;
  }

     void setEventDate(DateTime eventDate){
    _eventDate.value=eventDate;
  }

      void setLatitude(double latitude){
    _pickedLat.value=latitude;
  }
     void setLongitude(double longitude){
    _pickedLong.value=longitude;
  }

      void setAddress(String address){
    _pickedAddress.value=address;
  }

  Future<void> getCurrentLocation() async {
  try {
  print("called");
    Position position = await _determinePosition();
    print("Postition $position");
    _currentPosition.value = position; // Update Rx variable
    print("Current ${_currentPosition.value!.latitude}");
    update();
  } catch (e) {
    print(e); // Handle errors
  }
}

Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    isLocationDisabled.value = !serviceEnabled;

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void openLocationSetting() async{
      // OpenAppsSettings.openAppsSettings(
      //                         settingsCode: SettingsCode.LOCATION,);
    // isLocationDisabled.value = !(await Geolocator.isLocationServiceEnabled());

    print("Location Disabled ${isLocationDisabled.value}");
    
  }





@override
  void onInit() {
      getCurrentLocation();
    // openLocationSetting();
    super.onInit();
  }







}

class CreateSaduditharModel{
  final String title;
  final String description;
  final int categoryId;
  final int cityId;
  final int townshipId;
  final String type;

  final int estimatedAmount;
  final String estimatedTime;
  final String estimatedQuantity;
  final DateTime actualStartTime;
  final DateTime actualEndTime;
  final String address;
  final String phone;
  final String status;
  final DateTime eventDate;
  final double? latitude;
  final double? longitude;
  

  CreateSaduditharModel({required this.title, required this.description,required this.categoryId, required this.cityId, required this.townshipId, required this.type, required this.estimatedAmount, required this.estimatedTime, required this.estimatedQuantity, required this.actualStartTime, required this.actualEndTime, required this.address, required this.phone, required this.status, required this.eventDate,required this.latitude,required this.longitude});
}