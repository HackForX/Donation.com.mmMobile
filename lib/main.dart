import 'dart:io';

import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/views/app_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
   await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  
  
 final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  await MySharedPref.init(sharedPreferences);
  if(Platform.isAndroid){
    await  Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyDhnpbNHv-NFZzimqcoPv14o1l9a1GBO28",
  authDomain: "donationcommm.firebaseapp.com",
  projectId: "donationcommm",
  storageBucket: "donationcommm.appspot.com",
  messagingSenderId: "268293076947",
  appId: "1:268293076947:web:3bdad36b74331854ffa126",
  measurementId: "G-8ZVT039D82")
  );
  }else{
    await Firebase.initializeApp();
  }
  configLoading();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgound);
  await Upgrader.clearSavedSettings();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
    child: const AppView()));
}




@pragma('vm:entry-point')
Future<void> _firebaseMessageBackgound(RemoteMessage message) async {
  Firebase.initializeApp();
  print(message.notification!.title.toString());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingFour
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..progressColor = ColorApp.secondaryColor
    ..backgroundColor = ColorApp.mainColor.withOpacity(0.5)
    ..indicatorColor = ColorApp.secondaryColor
    ..textColor = ColorApp.secondaryColor
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.clear
    ..dismissOnTap = true;
}