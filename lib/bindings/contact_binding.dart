

import 'package:donation_com_mm_v2/controllers/contact_controller.dart';
import 'package:donation_com_mm_v2/controllers/history_controller.dart';
import 'package:donation_com_mm_v2/controllers/natebanzay_chat_controller.dart';


import 'package:get/get.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactController(),);
  }
}