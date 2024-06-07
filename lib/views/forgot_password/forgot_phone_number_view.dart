import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';


class ForgotPhoneNumberView extends StatelessWidget {
  ForgotPhoneNumberView({super.key});

  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _phoneController = TextEditingController();

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
                      "FORGOT PASSWORD",
                      style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 18,
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
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          labelText: "Phone Number",
                          labelStyle:  TextStyle(
                              color: ColorApp.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide:
                                  BorderSide(color: ColorApp.bgColorGrey)),
                          focusedBorder: const OutlineInputBorder(
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
                   Obx(() => Padding(
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
                           await   _authController.forgotPassword(
                            context,
                                  _phoneController.text);
                            },
                            child:  _authController.apiCallStatus==ApiCallStatus.loading?const ButtonLoaderWidget():Text(
                              "Next",
                              style: TextStyle(
                                  color: ColorApp.mainColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ),)
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
