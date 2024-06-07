import 'package:donation_com_mm_v2/models/notification_response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';
import '../util/app_config.dart';
import '../util/share_pref_helper.dart';

class NotificationController extends GetxController{
 final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();
     final RxList<Notification> _notifications = RxList.empty();
  List<Notification> get notifications => _notifications.toList();


  Future<void> getNotifications() async {
    await _baseClient.safeApiCall(
      AppConfig.notificationsUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;
        
        _apiCallStatus.value = ApiCallStatus.loading;
   
      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.success;

        NotificationResponse notificationResponse = NotificationResponse.fromJson(response.data);
        _notifications.value = notificationResponse.data;
     
      },

      onError: (error) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);

      },
    );
  }


@override
  void onInit() {
getNotifications()  ;
    super.onInit();
  }
}