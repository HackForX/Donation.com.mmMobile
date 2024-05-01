// import 'package:get/get.dart';

// import '../routes/app_pages.dart';

// class SplashScreenController extends GetxController {
//   RxBool isLoggedIn = false.obs;
// //   RxBool isOnboarding = false.obs;

// //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// //   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();
// //   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// //   @override
// //   void onReady() async {
// //     ever(isLoggedIn, (bool? isLoggedInValue) {
// //       if (isLoggedInValue != null) {
// //         handleAuthStateChanges(isLoggedInValue, isOnboarding.value);
// //       }
// //     });

// //     ever(isOnboarding, (bool? isOnboardingValue) {
// //       if (isOnboardingValue != null) {
// //         handleAuthStateChanges(isLoggedIn.value, isOnboardingValue);
// //       }
// //     });

// //     // Check shared preferences for login status
// //     isLoggedIn.value = await getLoginStatus();
// //     print("P${await getOnboardingStatus()}");
// //     isOnboarding.value = await getOnboardingStatus();

// //     print("Q${isOnboarding.value}");

// //     // firebaseAuth.authStateChanges().listen((user) {
// //     //   isLoggedIn.value = user != null;
// //     //   // Save the login status in shared preferences
// //     //   saveLoginStatus(isLoggedIn.value);
// //     // });

// //     super.onReady();
// //   }

// //   handleAuthStateChanges(signIn, isOnboarding) {
// //     if (signIn) {

// //     } else {
// //       if (isOnboarding) {
// //         Future.delayed(const Duration(milliseconds: 1500),
// //             () => Get.offAll(() => SignUpView()));
// //       } else {
// //         Future.delayed(const Duration(milliseconds: 1500),
// //             () => Get.offAll(() => const OnboardingView()));
// //       }
// //     }
// //   }

// //   // Save login status in shared preferences
// //   Future<void> saveLoginStatus(bool isLoggedIn) async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     prefs.setBool('isLoggedIn', isLoggedIn);
// //   }

// //   Future<bool> getOnboardingStatus() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return prefs.getBool('isOnboarding') ?? false;
// //   }

// //   // Get login status from shared preferences
// //   Future<bool> getLoginStatus() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return prefs.getBool('isLoggedIn') ?? false;
// //   }

// //   void requestPermission() async {
// //     NotificationSettings settings = await _firebaseMessaging.requestPermission(
// //         alert: true,
// //         announcement: true,
// //         badge: true,
// //         carPlay: true,
// //         criticalAlert: true,
// //         provisional: true,
// //         sound: true);

// //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
// //       print("User Granted the permission");
// //     } else if (settings.authorizationStatus ==
// //         AuthorizationStatus.provisional) {
// //       print("User access is provisional");
// //     } else {
// //       print("User Access is denied");
// //     }

// //     await _firebaseMessaging.subscribeToTopic('all');
// //   }

// //   //step 2

// //   getToken() async {
// //     await _firebaseMessaging.getToken().then((value) async {
// //       print("My Token is $value");
// //       // await firestore.collection("tokens").doc(value).set({"token": value});
// //     });
// //   }

// // //step 4
// //   void firebaseInit() {
// //     FirebaseMessaging.onMessage.listen((messaging) {
// //       showNotification(messaging);
// //       print(messaging.notification!.title.toString());
// //       print(messaging.notification!.body.toString());
// //     });
// //     FirebaseMessaging.onMessageOpenedApp.listen((messaging) {
// //       showNotification(messaging);
// //       print(messaging.notification!.title.toString());
// //       print(messaging.notification!.body.toString());
// //     });
// //   }

// //   //

// //   //step 5
// //   void initLocalInitialization() async {
// //     var androidIntialization =
// //         const AndroidInitializationSettings('@mipmap/ic_launcher');
// //     var initialSettings = InitializationSettings(android: androidIntialization);

// //     await _flutterLocalNotificationsPlugin.initialize(initialSettings,
// //         onDidReceiveNotificationResponse: (payload) {});
// //   }

// //   //step 6
// //   Future<void> showNotification(RemoteMessage message) async {
// //     // channel for id and name
// //     AndroidNotificationChannel channel = const AndroidNotificationChannel(
// //         "channel_id", "High Importance",
// //         importance: Importance.max);
// //     // notification details
// //     AndroidNotificationDetails androidNotificationDetails =
// //         AndroidNotificationDetails("Channel_id", channel.name.toString(),
// //             importance: Importance.high,
// //             icon: "@mipmap/ic_launcher",
// //             priority: Priority.high,
// //             ticker: 'ticker');
// //     // put the andoid notification to notification details
// //     NotificationDetails notificationDetails =
// //         NotificationDetails(android: androidNotificationDetails);

// //     // to show the notification on the screen
// //     Future.delayed(Duration.zero, () {
// //       _flutterLocalNotificationsPlugin.show(
// //           0,
// //           message.notification!.title.toString(),
// //           message.notification!.body.toString(),
// //           notificationDetails);
// //     });
// //   }

//   @override
//   void onInit() {
//     Future.delayed(
//       const Duration(milliseconds: 1500),
//       () => Get.offAllNamed(Routes.main),
//     );
//     super.onInit();
//   }
// }

import 'dart:async';


import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:get/get.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';


class SplashController extends GetxController {
  Timer? _timer;

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  bool invalidToken = false;
  final BaseClient _baseClient = BaseClient();

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
        Get.offNamed(Routes.login);
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

  @override
  void onInit() {
    getDonors();
    checkAuthenticationStatus();


    super.onInit();
  }

  @override
  void onClose() {
    _timer
        ?.cancel(); // Make sure to cancel the timer when the controller is closed
    super.onClose();
  }
}

