// }

import 'package:get/get.dart';

class CustomMenuController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
