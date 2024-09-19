import 'package:donation_com_mm_v2/models/contact_response.dart';
import 'package:get/get.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';
import '../models/sadudithar_response.dart';
import '../util/app_config.dart';
import '../util/share_pref_helper.dart';

class ContactController extends GetxController{
 final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;

     final Rxn<Contact> _contact = Rxn<Contact>();
  Contact? get contact => _contact.value;


 




  final BaseClient _baseClient = BaseClient();

  
  Future<void> getContact() async {
    await _baseClient.safeApiCall(
      AppConfig.contactUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        _apiCallStatus.value=ApiCallStatus.loading;
      },
      onSuccess: (response) {
        _apiCallStatus.value=ApiCallStatus.success;


        ContactResponse contactResponse = ContactResponse.fromJson(response.data);
        _contact.value = contactResponse.data;

      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);

      },
    );
  }


  @override
  void onInit() {
    getContact()  ;
    super.onInit();
  }

}