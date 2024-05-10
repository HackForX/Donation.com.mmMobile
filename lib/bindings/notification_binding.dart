

import 'package:donation_com_mm_v2/controllers/notification_controller.dart';

import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}