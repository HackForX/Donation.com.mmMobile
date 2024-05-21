import 'package:get/get.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';
import '../models/sadudithar_response.dart';
import '../util/app_config.dart';
import '../util/share_pref_helper.dart';

class HistoryController extends GetxController{
 final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;

  final RxList<Sadudithar> _sadudithars = RxList.empty();
  List<Sadudithar> get sadudithars => _sadudithars.toList();


 




  final BaseClient _baseClient = BaseClient();

  Future<void> getHistory() async {
    await _baseClient.safeApiCall(
      AppConfig.historyUrl, // url
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

        SaduditharResponse saduditharResponse = SaduditharResponse.fromJson(response.data);
        _sadudithars.value = saduditharResponse.data;
        


      },

      onError: (error) {
    _apiCallStatus.value=ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);

      },
    );
  }

  @override
  void onInit() {
    getHistory()  ;
    super.onInit();
  }

}