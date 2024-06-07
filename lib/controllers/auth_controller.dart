import 'dart:async';

import 'package:donation_com_mm_v2/models/login_response.dart';
import 'package:donation_com_mm_v2/models/register_response.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api_call_status.dart';
import '../core/base_client.dart';
import '../routes/app_pages.dart';
import '../views/auth/register/pin_code_view.dart';
import '../views/forgot_password/forgot_password_view.dart';
import '../views/forgot_password/forgot_pin_code_view.dart';

class AuthController extends GetxController {
  List<dynamic>? data;

  final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus  get apiCallStatus => _apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final RxString _selectedGender = "".obs;
  String get selectedGender => _selectedGender.value;
  final RxString _selectedAge = "".obs;
  String get selectedAge => _selectedAge.value;

    final RxString _pin = "".obs;
  String get pin => _pin.value;

  final RxString _requestId = "".obs;
  String get requestId => _requestId.value;
  RxInt secondsRemaining = 60.obs;
  late Timer timer;

   void startTimer() {
    const int resendTimeout = 60;
    secondsRemaining.value = resendTimeout;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel(); // Cancel the timer when it reaches zero
      }
    });
  }

  login(
    String phone, String password, BuildContext context) async {
    await _baseClient.safeApiCall(
      AppConfig.signInUrl, // url
      RequestType.post,
      queryParameters: {"password":password,"phone":phone},
      onLoading: () {

        _apiCallStatus.value = ApiCallStatus.loading;
     
      },
      onSuccess: (response) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        MySharedPref.setUserName(loginResponse.user.name);
          MySharedPref.setToken(loginResponse.token);
        MySharedPref.setUserId(loginResponse.user.id);
        ToastHelper.showSuccessToast(context, "Successfully logined as ${loginResponse.user.name}");
        Get.offAllNamed(Routes.main);
        _apiCallStatus.value= ApiCallStatus.success;
      
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        
      ToastHelper.showErrorToast(context,error.response!.data["message"]);
      }
    );
  }


  register(
      String name, String phone, String password,String age, String gender) async {
    await _baseClient.safeApiCall(
      AppConfig.signUpUrl, // url
      RequestType.post,
      queryParameters: {"name": name, "phone": phone, "password": password,"age":age,"gender":gender},
      onLoading: () {

       _apiCallStatus.value = ApiCallStatus.loading;
  
      },
      onSuccess: (response) {
        RegisterResponse registerResponse = RegisterResponse.fromJson(response.data);
        MySharedPref.setUserName(registerResponse.user.name);
               MySharedPref.setToken(registerResponse.token);
      
        MySharedPref.setUserId(registerResponse.user.id);
        // ToastHelper.showSuccessToast(context, "Successfully created an account");
        EasyLoading.showSuccess("Scuccess");
        Get.offAllNamed(Routes.main);
        _apiCallStatus.value = ApiCallStatus.success;
  
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
  
   
  
      },
    );
  }


  checkExist(
   String name, String phone,String password,String age, String gender) async {
    await _baseClient.safeApiCall(
      AppConfig.checkUserExistenceUrl, // url
      RequestType.get,
      queryParameters: {"phone": phone, },
      onLoading: () {

       _apiCallStatus.value = ApiCallStatus.loading;
  
      },
      onSuccess: (response) async{
        if(response.data['exist']==true){
          EasyLoading.showError("User exists");
        }else{
          await  verifyPhoneNumber(name, phone, password, age, gender);
 
        }

        _apiCallStatus.value = ApiCallStatus.success;
  
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
  
   
  
      },
    );
  }


  forgotPassword(
    BuildContext context,
String phone) async {
_apiCallStatus.value=ApiCallStatus.loading;
    await _baseClient.safeApiCall(
      AppConfig.forgotPasswordUrl, // url
      RequestType.post,
      queryParameters: {"phone": phone, },
      onLoading: () {

       _apiCallStatus.value = ApiCallStatus.loading;
  
      },
      onSuccess: (response) async{
        _apiCallStatus.value=ApiCallStatus.success;
        String token=response.data['token'];
          await  verifyForgotPhoneNumber(token,phone);

        _apiCallStatus.value = ApiCallStatus.success;
  
      },

      onError: (error) {
         if(error.statusCode==404){
        ToastHelper.showErrorToast(context,"Phone number not found");
          
        }
        _apiCallStatus.value = ApiCallStatus.error;
  
   
  
      },
    );
  }


  resetPassword(
   String token, String phone,String password) async {
    await _baseClient.safeApiCall(
      AppConfig.resetPasswordUrl, // url
      RequestType.post,
      queryParameters: {"phone": phone,"token":token,"password":password },
      onLoading: () {

       _apiCallStatus.value = ApiCallStatus.loading;
  
      },
      onSuccess: (response) async{
        EasyLoading.showSuccess("Success");
       Get.offAllNamed(Routes.login);

        _apiCallStatus.value = ApiCallStatus.success;
  
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
  
   
  
      },
    );
  }



  Future<void> verifyPhoneNumber(String name, String phone, String password,
      String age, String gender) async {
        print("CDDSDF");
    EasyLoading.show(status: "Loading..");
    await _baseClient.safeApiCall(
      'https://verify.smspoh.com/api/v2/request', // url
      RequestType.post,

      queryParameters: {
        "to": phone,
        "access-token":
            'hU9DDJ-3Vwcqcgekmvstr8Z_FtB5T-ZHZYZh9r06pHxWb1cQWjaH9yFO2U-u-1LZ',
        "brand_name": 'Donation MM',
        // "sender_name":'Donation MM'
      },
      onLoading: () {
             _apiCallStatus.value  = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        print("Request ${response.data['request_id']}");

        setRequestId(response.data['request_id'].toString());
        

        Get.to(() => PinCodeVerificationScreen(
              requestId: response.data['request_id'].toString(),
              phoneNumber: phone,
              name: name,
              password: password,
              age: age,
              gender: gender,
            ));
             _apiCallStatus.value  = ApiCallStatus.success;
        EasyLoading.dismiss();

      },

      onError: (error) {
        print(error.message);
        EasyLoading.dismiss();

             _apiCallStatus.value  = ApiCallStatus.error;

      },
    );
  }

  Future<void> signInWithGoogle()async{
     try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        EasyLoading.showToast("Cancelled");
      }
      EasyLoading.show(status: "Loading...");
      final googleAuthentication = await googleUser!.authentication;
      print("Token ${googleAuthentication.accessToken}");
    await socialSignInWithToken("google", googleAuthentication.accessToken??"");

      // final authCredential = GoogleAuthProvider.credential(
      //     idToken: googleAuthentication.idToken,
      //     accessToken: googleAuthentication.accessToken);

      // final cred =
      //     await FirebaseAuth.instance.signInWithCredential(authCredential);

      EasyLoading.dismiss();
    } on PlatformException catch (e) {
      print("ERror ${e.toString()}");

      if (e.code == "sign_in_canceled") {
        EasyLoading.showToast("Cancelled");
        EasyLoading.dismiss();
      }
    } on FirebaseAuthException catch (e) {
      print("ERror ${e.toString()}");

      if (e.code == "account-exists-with-different-credential") {
        EasyLoading.showToast("Account Exists With Different Method");
        EasyLoading.dismiss();
      }
      EasyLoading.showToast("Something wrong");
      EasyLoading.dismiss();
    } catch (e) {
      print("ERror ${e.toString()}");
      EasyLoading.showToast(e.toString());
    }
  }

// Future<void> signInWithApple() async {
//   try {
//     // 1. Request Apple ID credential
//     final appleCredential = await SignInWithApple.fromAuthResult(await SignInWithApple.getAuthResult());

//     // 2. Check if cancelled
//     if (appleCredential.credentialState == AuthorizationCredentialState.canceled) {
//       EasyLoading.showToast("Cancelled");
//       return;
//     }

//     // 3. Extract identity token
//     final identityToken = String.fromCharCodes(appleCredential.identityToken);
//     print("Identity Token: $identityToken");

//     // 4. Exchange for your server-side token (if needed)
//     // This step depends on your backend implementation
//     // You might call your server to exchange the identityToken for your own token

//     // 5. Sign in to Firebase with the token obtained from your server (or identityToken)
//     // Replace "your_server_token" with the actual token
//     final credential = await FirebaseAuth.instance.signInWithCredential(
//       OAuthProvider.credential(
//         providerId: 'apple.com',
//         accessToken: "your_server_token", // or identityToken
//       ),
//     );

//     // 6. Handle successful sign in
//     print("Signed in with Apple UID: ${credential.user!.uid}");
//     EasyLoading.dismiss();

//   } on PlatformException catch (e) {
//     print("Error: ${e.toString()}");
//     if (e.code == 'sign_in_canceled') {
//       EasyLoading.showToast("Cancelled");
//     } else {
//       EasyLoading.showToast("Sign in failed");
//     }
//   } catch (e) {
//     print("Error: ${e.toString()}");
//     EasyLoading.showToast("Something went wrong");
//   } finally {
//     EasyLoading.dismiss();
//   }
// }





  Future<void> signInWithFacebook() async {
    try {
      FacebookAuth facebookAuth = FacebookAuth.instance;

      LoginResult result =
          await facebookAuth.login(permissions: ["public_profile", "email"]);
      if (result.status == LoginStatus.success) {
        AccessToken? token = await facebookAuth.accessToken;
    print("Access TOken ${token!.token}");
    await socialSignInWithToken("facebook", token.token);
        EasyLoading.dismiss();
      } else {
        EasyLoading.showToast("Failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        EasyLoading.showToast("Account Exists With Different Method");
      } else {
        EasyLoading.showToast("Something went wrong");
      }
    }
  }


  appleSignInWithCode(

      String token) async {
        EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ");
    await _baseClient.safeApiCall(
     AppConfig.appleSignInUrl, // url
      RequestType.post,
      queryParameters: {"token": token},
      onLoading: () {

       _apiCallStatus.value = ApiCallStatus.loading;
  
      },
      onSuccess: (response) {
        RegisterResponse registerResponse = RegisterResponse.fromJson(response.data);
        MySharedPref.setUserName(registerResponse.user.name);
               MySharedPref.setToken(registerResponse.token);
      
        MySharedPref.setUserId(registerResponse.user.id);
        // ToastHelper.showSuccessToast(context, "Successfully created an account");
        EasyLoading.showSuccess("Scuccess");
        Get.offAllNamed(Routes.main);
        _apiCallStatus.value = ApiCallStatus.success;
        EasyLoading.dismiss();
  
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
  
        EasyLoading.dismiss();
   
  
      },
    );
  }



  socialSignInWithToken(
    String provider,
      String token) async {
    await _baseClient.safeApiCall(
     "${AppConfig.signInUrl}/$provider/token", // url
      RequestType.post,
      queryParameters: {"access_token": token,},
      onLoading: () {

       _apiCallStatus.value = ApiCallStatus.loading;
  
      },
      onSuccess: (response) {
        RegisterResponse registerResponse = RegisterResponse.fromJson(response.data);
        MySharedPref.setUserName(registerResponse.user.name);
               MySharedPref.setToken(registerResponse.token);
      
        MySharedPref.setUserId(registerResponse.user.id);
        // ToastHelper.showSuccessToast(context, "Successfully created an account");
        EasyLoading.showSuccess("Scuccess");
        Get.offAllNamed(Routes.main);
        _apiCallStatus.value = ApiCallStatus.success;
  
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
  
   
  
      },
    );
  }


  Future<void> verifyForgotPhoneNumber(String token,String phone) async {
    EasyLoading.show(status: "Loading..");
    await _baseClient.safeApiCall(
      'https://verify.smspoh.com/api/v2/request', // url
      RequestType.post,

      queryParameters: {
          "to": phone,
        "access-token":
            'hU9DDJ-3Vwcqcgekmvstr8Z_FtB5T-ZHZYZh9r06pHxWb1cQWjaH9yFO2U-u-1LZ',
        "brand_name": 'Donation MM',
   

      },
      onLoading: () {
             _apiCallStatus.value  = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        print(response.data['request_id']);

        setRequestId(response.data['request_id'].toString());

        Get.to(() => ForgotPinCodeView(
          token: token,
              requestId: response.data['request_id'].toString(),
              phoneNumber: phone,
            ));
             _apiCallStatus.value  = ApiCallStatus.success;
        EasyLoading.dismiss();

      },

      onError: (error) {
        print(error.message);
        EasyLoading.dismiss();

             _apiCallStatus.value  = ApiCallStatus.error;

      },
    );
  }

  Future<void> resendCOde(String name, String phone, String password, String age,
      String gender) async {
    EasyLoading.show(status: "Loading..");
    await _baseClient.safeApiCall(
      'https://verify.smspoh.com/api/v2/request', // url
      RequestType.post,

      queryParameters: {
          "to": phone,
        "access-token":
            'hU9DDJ-3Vwcqcgekmvstr8Z_FtB5T-ZHZYZh9r06pHxWb1cQWjaH9yFO2U-u-1LZ',
        "brand_name": 'Donation MM',
      },
      onLoading: () {
             _apiCallStatus.value  = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        print(response.data['request_id']);

        setRequestId(response.data['request_id'].toString());

        // _resendCode

        Get.off(() => PinCodeVerificationScreen(
              requestId: response.data['request_id'].toString(),
              phoneNumber: phone,
              name: name,
              password: password,
              age: age,
              gender: gender,
            ));
             _apiCallStatus.value  = ApiCallStatus.success;
        EasyLoading.dismiss();

      },

      onError: (error) {
        print(error.message);
        EasyLoading.dismiss();

             _apiCallStatus.value  = ApiCallStatus.error;

      },
    );
  }

    Future<void> resendForgotCode(String token,String phone ) async {
    EasyLoading.show(status: "Loading..");
    await _baseClient.safeApiCall(
      'https://verify.smspoh.com/api/v2/request', // url
      RequestType.post,

      queryParameters: {
    "to": phone,
        "access-token":
            'hU9DDJ-3Vwcqcgekmvstr8Z_FtB5T-ZHZYZh9r06pHxWb1cQWjaH9yFO2U-u-1LZ',
        "brand_name": 'Donation MM',
 
      },
      onLoading: () {
             _apiCallStatus.value  = ApiCallStatus.loading;

      },
      onSuccess: (response) {
        print(response.data['request_id']);

        setRequestId(response.data['request_id'].toString());

        // _resendCode

        Get.off(() => ForgotPinCodeView(
              requestId: response.data['request_id'].toString(),
              phoneNumber: phone,
              token: token,
            
            ));
             _apiCallStatus.value  = ApiCallStatus.success;
        EasyLoading.dismiss();

      },

      onError: (error) {
        print(error.message);
        EasyLoading.dismiss();

             _apiCallStatus.value  = ApiCallStatus.error;

      },
    );
  }

  Future<void> verifyPin(String name, String phone, String password, String age,
      String gender, String requestId, String code) async {
    EasyLoading.show(status: "Loading..");
    await _baseClient.safeApiCall(
      'https://verify.smspoh.com/api/v1/verify', // url
      RequestType.post,

      queryParameters: {
        "request_id": requestId,
        "access-token":
            'hU9DDJ-3Vwcqcgekmvstr8Z_FtB5T-ZHZYZh9r06pHxWb1cQWjaH9yFO2U-u-1LZ',
        "code": code
      },
      onLoading: () {
        _apiCallStatus.value = ApiCallStatus.loading;
      
      },
      onSuccess: (response) async {
        print(response.data['request_id']);

        await register(name, phone, password, age, gender);

        // signInWithPhonumber(name,phone);
        _apiCallStatus.value = ApiCallStatus.success;
        EasyLoading.dismiss();

      },

      onError: (error) {
        print(error.message);
        EasyLoading.dismiss();

        _apiCallStatus.value  = ApiCallStatus.error;

      },
    );
  }

  Future<void> verifyForgotPin(
    String token,
      String phone, String requestId, String code) async {
    EasyLoading.show(status: "Loading..");
    await _baseClient.safeApiCall(
      'https://verify.smspoh.com/api/v1/verify', // url
      RequestType.post,

      queryParameters: {
        "request_id": requestId,
        "access-token":
            'hU9DDJ-3Vwcqcgekmvstr8Z_FtB5T-ZHZYZh9r06pHxWb1cQWjaH9yFO2U-u-1LZ',
        "code": code
      },
      onLoading: () {
        _apiCallStatus.value = ApiCallStatus.loading;
   
      },
      onSuccess: (response) async {
        print(response.data['request_id']);

        Get.to(() => ForgotPasswordView(
          token: token,
              phone: phone,
            ));

        // signInWithPhonumber(name,phone);
        _apiCallStatus.value = ApiCallStatus.success;
        EasyLoading.dismiss();

      },

      onError: (error) {
        print(error.message);
        EasyLoading.dismiss();

        _apiCallStatus.value = ApiCallStatus.error;

      },
    );
  }


  logout(BuildContext context) async {
    // *) perform api call
    await _baseClient.safeApiCall(
      AppConfig.logOutUrl, // url
      RequestType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },
      onLoading: () {
        // *) indicate loading state

        _apiCallStatus.value = ApiCallStatus.loading;
       
      },
      onSuccess: (response) {
        // api done successfully
        MySharedPref.clear();

        Get.offAllNamed(Routes.login);

        ToastHelper.showSuccessToast(context, "Succesfully logout");

        // Get.offNamed(Routes.LOGIN);
        // *) indicate success state
        _apiCallStatus.value = ApiCallStatus.success;

        
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(apiException: error);

        // *) indicate error status
        _apiCallStatus.value = ApiCallStatus.error;
     
      },
    );
  }

  saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }

  setPin(String value) {
    _pin.value = value;
  }

  setRequestId(String value) {
    _requestId.value = value;
  }

  setSelectedAge(String value) {
    _selectedAge.value = value;
  }

  setSelectedGender(String gender) {
    _selectedGender.value = gender;
  }


  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.onClose();
  }

}
