import 'package:donation_com_mm_v2/controllers/sadudithar_details_controller.dart';
import 'package:get/get.dart';

class SaduditharDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SaduditharDetailsController());
  }
  
}