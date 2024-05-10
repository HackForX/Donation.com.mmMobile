import 'package:donation_com_mm_v2/controllers/natebanzay_request_controller.dart';
import 'package:get/get.dart';

class NatebanzayRequestBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NatebanzayRequestController())  ;
  }

}