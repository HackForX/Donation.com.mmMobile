import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      ImagePath.logo,
                      height: 80,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                     Text(
                      "Donation.com.mm",
                      style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        InkWell(
                          onTap: () {
                            _authController.signInWithGoogle();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Image.asset(IconPath.googleIcon),
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
                    Row(
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
                        GestureDetector(
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
                    )
                  ],
                ),
              ),
            ),
          ),
          // Positioned widgets (not affected by scrolling)
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
             ImagePath.bottomLeft,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              ImagePath.topLeft,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                ImagePath.bottomRight,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
               ImagePath.topRight,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),)
    );
  }
}
