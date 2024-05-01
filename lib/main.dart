import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/views/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:upgrader/upgrader.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  
  
 final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  await MySharedPref.init(sharedPreferences);
  // await  Firebase.initializeApp();
  // configLoading();
  // await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgound);
  await Upgrader.clearSavedSettings();
  runApp(const AppView());
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessageBackgound(RemoteMessage message) async {
//   Firebase.initializeApp();
//   print(message.notification!.title.toString());
// }

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..indicatorColor = ColorApp.secondaryColor
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
