import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';


class AgeGenderView extends StatelessWidget {
final String name;
  final String phone;
  final String password;
  AgeGenderView({super.key,required this.name, required this.phone, required this.password});

  final AuthController _authController = Get.put(AuthController());


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
                      height: 110,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                     Text(
                      "Birthday & Gender",
                      style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: SizedBox(
                          width: double.infinity,
                          child: Obx(
                              () => ElevatedButton(
                                
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorApp.mainColor,
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)))),
                                    onPressed: () {
                                      BottomPicker.date(
                                              pickerTitle: const Text("Set Your Birthday"),
                                              maxDateTime: DateTime.now(),
                                            pickerTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.blue),
                                              onChange: (index) {
                                                print(calculatedAge(index));
                                                _authController.setSelectedAge(
                                                    calculatedAge(index).toString());
                          
                                                print(index);
                                              },
                                              onSubmit: (index) {
                                                print(calculatedAge(index));
                                                _authController.setSelectedAge(
                                                    calculatedAge(index).toString());
                                              },
                                              bottomPickerTheme:
                                                  BottomPickerTheme.plumPlate)
                                          .show(context);
                                    },
                                    child: Text(
                                      _authController.selectedAge .isEmpty
                                          ? "Birthday"
                                          : "${_authController.selectedAge.toString()}years",
                                      style:  TextStyle(
                                          color: ColorApp.secondaryColor,
                                          fontSize: 16),
                                    )),
                            ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorApp.mainColor,
                                side: const BorderSide(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4)))),
                            onPressed: () {
                              BottomPicker(
                                items: const [
                                  Text('Male'),
                                  Text('Female'),
                                ],
                                pickerTitle: const Text("Select Gender"),
                                onChange: (index) {
                                  print(index);
                                  _authController.setSelectedGender(
                                      index == 0 ? "Male" : "Female");
                                },
                                onSubmit: (index) {
                                  print(index);
                                  _authController.setSelectedGender(
                                      index == 0 ? "Male" : "Female");
                                },
                                pickerTextStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).show(context);
                            },
                            child: Text(
                              _authController.selectedGender.isEmpty
                                  ? "Gender"
                                  : _authController.selectedGender,
                              style:  TextStyle(
                                  color: ColorApp.secondaryColor,
                                  fontSize: 16),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: ColorApp.secondaryColor),
                                  onPressed: () async {
                                    // if (_formKey.currentState!.validate()) {
                                    //   _authController.resetPassword(
                                    //     token,
                                    //       phone, _newPasswordController.text);
                                    // }
                                                             _authController.checkExist(name, phone, password, '__', '__');
                                  },
                                  child:  _authController.apiCallStatus==ApiCallStatus.loading?const ButtonLoaderWidget():Text(
                                    "Skip",
                                    style: TextStyle(
                                        color: ColorApp.mainColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: ColorApp.secondaryColor),
                                  onPressed: () async {
                                    // if (_formKey.currentState!.validate()) {
                                    //   _authController.resetPassword(
                                    //     token,
                                    //       phone, _newPasswordController.text);
                                    // }
                                                      if(_authController.selectedAge==""){
                                                        ToastHelper.showErrorToast(context, "Please select age");
                                                      }
                                                      else if(_authController.selectedGender==""){
                                                        ToastHelper.showErrorToast(context, "Please select gender");
                                                      }else{
                                                            _authController.checkExist(name, phone, password, _authController.selectedAge, _authController.selectedGender);
                                                      }
                                  },
                                  child:  _authController.apiCallStatus==ApiCallStatus.loading?const ButtonLoaderWidget():Text(
                                    "Save",
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


  int calculatedAge(DateTime birthDate) {
    // Parse the string into a DateTime object

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference between the current date and the birth date
    Duration difference = currentDate.difference(birthDate);

    // Calculate the age in years
    int age = (difference.inDays / 365).floor();

    return age;
  }

}
