

import 'package:donation_com_mm_v2/controllers/natebanzay_chat_controller.dart';


import 'package:get/get.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NatebanzayChatController(),);
  }
}