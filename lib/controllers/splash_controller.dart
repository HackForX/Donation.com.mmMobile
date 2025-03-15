

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';


class SplashController extends GetxController {
  Timer? _timer;

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  bool invalidToken = false;
  final BaseClient _baseClient = BaseClient();
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  void checkAuthenticationStatus() async {
    if (MySharedPref.getToken() != null && !invalidToken) {
      // User is authenticated, navigate to home page
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        Get.offNamed(Routes.main);
        _timer?.cancel(); // Cancel the timer
        Get.delete<SplashController>();
      });
    } else {
      // User is not authenticated, navigate to registration page
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        Get.offNamed(Routes.main);
        _timer?.cancel(); // Cancel the timer
        Get.delete<SplashController>();
      });
    }
  }




  Future<void> getDonors() async {
    await _baseClient.safeApiCall(
      AppConfig.donorsUrl, // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;

       
        update();
      },

      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);
              if (error.response!.statusCode == 401) {
          invalidToken = true;
          MySharedPref.clear();
          update();
        }

      },
    );
  }

    void requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted the permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User access is provisional");
    } else {
      print("User Access is denied");
    }

    await _firebaseMessaging.subscribeToTopic('all');
  }

  //step 2

  getToken() async {
    await _firebaseMessaging.getToken().then((value) async {
      print("My Token is $value");
     saveToken(value??"");
    });
  }

//step 4
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((messaging) {
      showNotification(messaging);
      print(messaging.notification!.title.toString());
      print(messaging.notification!.body.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((messaging) {
      showNotification(messaging);
      print(messaging.notification!.title.toString());
      print(messaging.notification!.body.toString());
    });
  }

  //

  //step 5
  void initLocalInitialization() async {
    var androidIntialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initialSettings = InitializationSettings(android: androidIntialization);

    await _flutterLocalNotificationsPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (payload) {});
  }

  //step 6
  Future<void> showNotification(RemoteMessage message) async {
    // channel for id and name
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        "channel_id", "High Importance",
        importance: Importance.max);
    // notification details
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("Channel_id", channel.name.toString(),
            importance: Importance.high,
            icon: "@mipmap/ic_launcher",
            priority: Priority.high,
            ticker: 'ticker');
    // put the andoid notification to notification details
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // to show the notification on the screen
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }


  saveToken(
      String token) async {
    await _baseClient.safeApiCall(
      AppConfig.saveTokenUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      data: FormData.fromMap({
        "token": token,
      
      
      }),
      onLoading: () {

        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        print("Response ${response.data}");
        apiCallStatus=ApiCallStatus.success;
  
        update();
      },

      onError: (error) {
       
        apiCallStatus = ApiCallStatus.error;
  
        update();
      },
    );
  }



  @override
  void onInit() {
    getDonors();
    checkAuthenticationStatus();
      requestPermission();
    getToken();
    firebaseInit();
    initLocalInitialization();


    super.onInit();
  }

  @override
  void onClose() {
    _timer
        ?.cancel(); // Make sure to cancel the timer when the controller is closed
    super.onClose();
  }
}

