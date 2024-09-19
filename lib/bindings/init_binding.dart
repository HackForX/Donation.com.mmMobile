import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/controllers/history_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(),fenix: true);
    Get.lazyPut(() => HistoryController(),fenix: true);

  }
}
