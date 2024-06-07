import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../forgot_password/forgot_phone_number_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Use Scaffold for proper layout and scrolling behavior
      body: Obx(()=>Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorApp.mainColor,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                height: 60,
                    ),
                    Image.asset(
                      ImagePath.logo,
                      
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                     Center(
                       child: Text(
                        "Donation.com.mm",
                        style: TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                                           ),
                     ),
                    const SizedBox(
                      height: 15,
                    ),
                     Text(
                      "LOGIN",
                      style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone Number is required";
                          }
                          return null;
                        },
                        style:  TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration:  InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          labelText: "Phone Number",
                          labelStyle: TextStyle(
                              color: ColorApp.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                    filled: false
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        obscureText: true,
                      
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        style:  TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration:  InputDecoration(
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: ColorApp.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                       
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ForgotPhoneNumberView());
                      },
                      child:  Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: ColorApp.secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: ColorApp.secondaryColor),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _authController.login(
                                    _phoneController.text,
                                    _passwordController.text,context);
                              }
                            },
                            child:  _authController.apiCallStatus==ApiCallStatus.loading?const ButtonLoaderWidget():Text(
                              "Login",
                              style: TextStyle(
                                  color: ColorApp.mainColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Center(
                      child: Text(
                        "Or Login With",
                        style: TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Platform.isAndroid? InkWell(
                          onTap: () {
                            _authController.signInWithGoogle();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Image.asset(IconPath.googleIcon),
                          ),
                        ):InkWell(
                        onTap: () async{
final rawNonce = generateNonce();
final nonce = sha256ofString(rawNonce);
final appleCredential = await SignInWithApple.getAppleIDCredential(
  scopes: [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
  ],
  nonce: nonce,
);

await _authController.appleSignInWithCode(appleCredential.authorizationCode);

                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/icons/apple.png',height: 35,),
                        ),
                      ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            _authController.signInWithFacebook();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Image.asset(IconPath.facebookIcon),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: (){
                          Get.offAllNamed(Routes.register);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: ColorApp.secondaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Get.offAllNamed(Routes.register);
                              },
                              child:  Center(
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: ColorApp.secondaryColor,
                                      fontSize: 16),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Positioned widgets (not affected by scrolling)
          Positioned(
            bottom: 10,
            left: 0,
            child: Image.asset(
             ImagePath.bottomLeft,
       
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            child: Image.asset(
              ImagePath.topLeft,
    height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Image.asset(
                ImagePath.bottomRight,
              
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            child: Image.asset(
               ImagePath.topRight,
          
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),)
    );
  }


  String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
}
