import 'package:donation_com_mm_v2/controllers/create_natebanzay_controller.dart';

import 'package:get/get.dart';

class CreateNatebanzayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateNatebanzayController());
  }
}