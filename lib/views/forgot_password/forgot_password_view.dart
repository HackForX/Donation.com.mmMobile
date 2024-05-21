import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';


class ForgotPasswordView extends StatelessWidget {
  final String token;
  final String phone;
  ForgotPasswordView({super.key, required this.phone, required this.token});

  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Use Scaffold for proper layout and scrolling behavior
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration:  BoxDecoration(
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
                      height: 100,
                    ),
                    Image.asset(
                      ImagePath.logo,
                      height: 80,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                     Text(
                      "Change New Password",
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
                        obscureText: true,
                        controller: _newPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password too short";
                          }
                          return null;
                        },
                        style:  TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "New Password",
                          labelStyle: TextStyle(
                              color: ColorApp.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
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
                        controller: _confirmNewPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm Password is required";
                          }
                          if (value != _newPasswordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        style:  TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "Confirm New Password",
                          labelStyle: TextStyle(
                              color: ColorApp.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
                                _authController.resetPassword(
                                  token,
                                    phone, _newPasswordController.text);
                              }
                            },
                            child:  _authController.apiCallStatus==ApiCallStatus.loading?ButtonLoaderWidget():Text(
                              "Change",
                              style: TextStyle(
                                  color: ColorApp.mainColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ),
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
              "assets/images/bottom-left.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/top-left.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/bottom-right.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/top-right.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
