import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/controllers/create_natebanzay_controller.dart';
import 'package:donation_com_mm_v2/controllers/donor_register_controller.dart';
import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:get/get.dart';

class DonorRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorRegisterController(),fenix: true);
  }
}