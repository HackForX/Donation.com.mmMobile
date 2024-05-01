import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/core/base_client.dart';
import 'package:donation_com_mm_v2/models/category_response.dart';
import 'package:donation_com_mm_v2/models/city_response.dart';
import 'package:donation_com_mm_v2/models/donor_response.dart';
import 'package:donation_com_mm_v2/models/item_response.dart';
import 'package:donation_com_mm_v2/models/natebanay_request_response.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/models/township_response.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:get/get.dart';

class  HomeController extends GetxController{
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  final RxList<Sadudithar> _sadudithars = RxList.empty();
  List<Sadudithar> get sadudithars => _sadudithars.toList();
    final RxList<Natebanzay> _natebanzays = RxList.empty();
  List<Natebanzay> get natebanzays => _natebanzays.toList();
      final RxList<Natebanzay> _natebanzaysRequested = RxList.empty();
  List<Natebanzay> get natebanzaysRequested => _natebanzaysRequested.toList();
        final RxList<NatebanzayRequest> _natebanzaysRequests = RxList.empty();
  List<NatebanzayRequest> get natebanzaysRequests => _natebanzaysRequests.toList();
    final RxList<Donor> _donors = RxList.empty();
  List<Donor> get donors => _donors.toList();
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
        apiCallStatus = ApiCallStatus.success;

        SaduditharResponse saduditharResponse = SaduditharResponse.fromJson(response.data);
        _sadudithars.value = saduditharResponse.data;
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
      AppConfig.natebanzaysRequestedUrl, // url
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
      AppConfig.natebanzaysRequestsUrl, // url
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

  void setCity(String city){
    _selectedCity.value=city;
  }



  void setItem(Item item){
    _selectedItem.value=item;
  }





  @override
  void onInit() {
    getSadudithars();
    getDonors();
    getNatebanzays();
    getNatebanzaysRequested();
    getNatebanzaysRequests();
    getItems();
    getCities();


    super.onInit();
  }
}