import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/models/category_response.dart';
import 'package:donation_com_mm_v2/models/city_response.dart';
import 'package:donation_com_mm_v2/models/donor_response.dart';
import 'package:donation_com_mm_v2/models/item_response.dart';
import 'package:donation_com_mm_v2/models/natebanay_request_response.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:donation_com_mm_v2/models/profile_response.dart';
import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/models/township_response.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class  HomeController extends GetxController{
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  final RxList<Sadudithar> _sadudithars = RxList.empty();
  List<Sadudithar> get sadudithars => _sadudithars.toList();

  final RxList<Sadudithar> _nearbySadudithars = RxList.empty();
  List<Sadudithar> get nearbySadudithars => _nearbySadudithars.toList();
    final RxList<Natebanzay> _natebanzays = RxList.empty();
  List<Natebanzay> get natebanzays => _natebanzays.toList();
      final RxList<Natebanzay> _natebanzaysRequested = RxList.empty();
  List<Natebanzay> get natebanzaysRequested => _natebanzaysRequested.toList();
        final RxList<NatebanzayRequest> _natebanzaysRequests = RxList.empty();
  List<NatebanzayRequest> get natebanzaysRequests => _natebanzaysRequests.toList();
    final RxList<Donor> _donors = RxList.empty();
  List<Donor> get donors => _donors.toList();
     final Rxn<Profile> _profile = Rxn<Profile>();
  Profile? get profile => _profile.value;
      final RxList<Item> _items = RxList.empty();
  List<Item> get items => _items.toList();
        final RxList<SaduditharCategory> _categories = RxList.empty();
  List<SaduditharCategory> get categories => _categories.toList();
        final RxList<SaduditharCity> _cities = RxList.empty();
  List<SaduditharCity> get cities => _cities.toList();
       final RxList<Township> _townships = RxList.empty();
  List<Township> get townships => _townships.toList();
  final RxString _selectedCity=RxString("Select City");
  String get selectedCity=> _selectedCity.value;
  final Rx<Item> _selectedItem=Item(
    id: 0,
    name: "အမျိုးအစားရွေးပါ",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
  ).obs;
  Item get selectedItem => _selectedItem.value;

     final Rx<Position?> _currentPosition = Rx<Position?>(null);
   Position? get currentPositon => _currentPosition.value;




  final BaseClient _baseClient = BaseClient();

  Future<void> getSadudithars() async {
    await _baseClient.safeApiCall(
      AppConfig.saduditharsUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        print("Response ${response.data}");
        apiCallStatus = ApiCallStatus.success;

        SaduditharResponse saduditharResponse = SaduditharResponse.fromJson(response.data);
        _sadudithars.value = saduditharResponse.data;
          print("Sadudithar ${_sadudithars.length}");
        _nearbySadudithars.clear();
for (var sadudithar in _sadudithars) {
  print("Sadudithar: $sadudithar");
  if (currentPositon != null && sadudithar.latitude != null && sadudithar.longitude != null) {
    double distance = Geolocator.distanceBetween(
        currentPositon!.latitude, currentPositon!.longitude, sadudithar.latitude!, sadudithar.longitude!);
    print("Distance: $distance");
  
            if (!_nearbySadudithars.contains(sadudithar)) {
               if (distance < 1000) {
              _nearbySadudithars.add(sadudithar);
              print("Near by ${_nearbySadudithars.length}");
            }
            }
          
  } else {
    print("Error: Missing location data");
  }
}
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
      },
    );
  }



  Future<void> getDonors() async {
    await _baseClient.safeApiCall(
      AppConfig.donorsUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        DonorResponse donorResponse = DonorResponse.fromJson(response.data);
        _donors.value = donorResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
      },
    );
  }


  Future<void> getProfile() async {
    await _baseClient.safeApiCall(
      AppConfig.profileUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        ProfileResponse profileResponse = ProfileResponse.fromJson(response.data);
        _profile.value = profileResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
      },
    );
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
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        ItemResponse itemResponse = ItemResponse.fromJson(response.data);
        _items.value = itemResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
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
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        CategoryResponse categoryResponse = CategoryResponse.fromJson(response.data);
        _categories.value = categoryResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
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
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        CityResponse cityResponse = CityResponse.fromJson(response.data);
        _cities.value = cityResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
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
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        TownshipResponse townshipResponse = TownshipResponse.fromJson(response.data);
        _townships.value = townshipResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
      },
    );
  }



  Future<void> getNatebanzays() async {
    await _baseClient.safeApiCall(
      AppConfig.natebanzayUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        NatebanzayResponse natebanzayResponse = NatebanzayResponse.fromJson(response.data);
        _natebanzays.value = natebanzayResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
      },
    );
  }



  Future<void> getNatebanzaysRequested() async {
    await _baseClient.safeApiCall(
      AppConfig.shareNatebanzaysUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        NatebanzayResponse natebanzayResponse = NatebanzayResponse.fromJson(response.data);
        _natebanzaysRequested.value = natebanzayResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
      },
    );
  }


  Future<void> getNatebanzaysRequests() async {
    await _baseClient.safeApiCall(
      AppConfig.getNatebanzaysUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

        NatebanzayRequestResponse natebanzayRequestResponse = NatebanzayRequestResponse.fromJson(response.data);
        _natebanzaysRequests.value = natebanzayRequestResponse.data;
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
        update();
      },
    );
  }

  deleteNatebanzay(
      int id,BuildContext context) async {
    await _baseClient.safeApiCall(
      "${AppConfig.natebanzayUrl}/$id", // url
      RequestType.delete,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

     
      onLoading: () {

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus=ApiCallStatus.success;
        getNatebanzaysRequested();
        getNatebanzays();
        ToastHelper.showSuccessToast(context,"အလှုကိုအောင်မြင်စွာဖျက်ပီးပါပီ");
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
  
        update();
      },
    );
  }

  void setCity(String city){
    _selectedCity.value=city;
  }



  void setItem(Item item){
    _selectedItem.value=item;
  }


  Future<void> getCurrentLocation() async {
  try {
  print("called");
    Position position = await _determinePosition();
    
    print("Postition $position");
    _currentPosition.value = position; // Update Rx variable
    print("Current ${_currentPosition.value!.latitude}");
  } catch (e) {
    print("Error $e");
    print(e); // Handle errors
  }
}



Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;


  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("Service Not Enabled")  ;
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    print("Denied")  ;

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
    print("Always Denied")  ;

      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    print("Denied Forever")  ;

    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}







  @override
  void onInit() async{
      await getCurrentLocation();
    getSadudithars();
    getProfile();

    getDonors();
    getNatebanzays();
    getNatebanzaysRequested();
    getNatebanzaysRequests();
    getItems();
    getCities();


    super.onInit();
  }
}