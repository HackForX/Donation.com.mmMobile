import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/button_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import '../login/login_view.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.mainColor,
      resizeToAvoidBottomInset: false,
      body: AuthFormWidget(
        nameController: _nameController,
        phoneController: _phoneController,
        passwordController: _passwordController,
        authController: _authController,
      ),
    );
  }
}

class AuthFormWidget extends StatelessWidget {
  AuthFormWidget({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
    required AuthController authController,
  })  : _nameController = nameController,
        _phoneController = phoneController,
        _passwordController = passwordController,
        _authController = authController;

  final TextEditingController _nameController;
  final TextEditingController _phoneController;
  final TextEditingController _passwordController;
  final AuthController _authController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  const SizedBox(height: 15),
                  Text(
                    "Donation.com.mm",
                    style: TextStyle(
                        color: ColorApp.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: ColorApp.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is Required";
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      filled: false
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone Number is Required";
                        }
                        if (validateMyanmarPhoneNumber(value)) {
                          return "Invalid Format";
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
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
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is Required";
                        }
                        if (value.length < 6) {
                          return "Password length too short";
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: ColorApp.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                    filled: false
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  //   child: Row(
                  //     children: [
                  //       Obx(
                  //         () => Expanded(
                  //           flex: 2,
                  //           child: ElevatedButton(
                  //               style: ElevatedButton.styleFrom(
                  //                   backgroundColor: ColorApp.mainColor,
                  //                   side: const BorderSide(
                  //                     color: Colors.white,
                  //                   ),
                  //                   shape: const RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(4)))),
                  //               onPressed: () {
                  //                 BottomPicker.date(
                  //                         pickerTitle:
                  //                             const Text("Set Your Birthday"),
                  //                         maxDateTime: DateTime.now(),
                  //                         pickerTextStyle: const TextStyle(
                  //                             fontWeight: FontWeight.bold,
                  //                             fontSize: 15,
                  //                             color: Colors.blue),
                  //                         onChange: (index) {
                  //                           print(calculatedAge(index));
                  //                           _authController.setSelectedAge(
                  //                               calculatedAge(index));

                  //                           print(index);
                  //                         },
                  //                         onSubmit: (index) {
                  //                           print(calculatedAge(index));
                  //                           _authController.setSelectedAge(
                  //                               calculatedAge(index));
                  //                         },
                  //                         bottomPickerTheme:
                  //                             BottomPickerTheme.plumPlate)
                  //                     .show(context);
                  //               },
                  //               child: Text(
                  //                 _authController.selectedAge == 0
                  //                     ? "Birthday"
                  //                     : "${_authController.selectedAge.toString()}years",
                  //                 style: const TextStyle(
                  //                     color: AppColors.secondaryColor,
                  //                     fontSize: 16),
                  //               )),
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       // Obx(
                  //       //   () => Expanded(
                  //       //     flex: 2,
                  //       //     child: ElevatedButton(
                  //       //         style: ElevatedButton.styleFrom(
                  //       //             backgroundColor:  ColorApp.mainColor,
                  //       //             side: const BorderSide(color: Colors.white),
                  //       //             shape: const RoundedRectangleBorder(
                  //       //                 borderRadius: BorderRadius.all(
                  //       //                     Radius.circular(4)))),
                  //       //         onPressed: () {
                  //       //           BottomPicker(
                  //       //             items: const [
                  //       //               Text('Male'),
                  //       //               Text('Female'),
                  //       //             ],
                  //       //             pickerTitle: const Text("Select Gender"),
                  //       //             onChange: (index) {
                  //       //               print(index);
                  //       //               _authController.setSelectedGender(
                  //       //                   index == 0 ? "Male" : "Female");
                  //       //             },
                  //       //             onSubmit: (index) {
                  //       //               print(index);
                  //       //               _authController.setSelectedGender(
                  //       //                   index == 0 ? "Male" : "Female");
                  //       //             },
                  //       //             pickerTextStyle: const TextStyle(
                  //       //               color: Colors.blue,
                  //       //               fontSize: 20,
                  //       //               fontWeight: FontWeight.bold,
                  //       //             ),
                  //       //           ).show(context);
                  //       //         },
                  //       //         child: Text(
                  //       //           _authController.selectedGender.isEmpty
                  //       //               ? "Gender"
                  //       //               : _authController.selectedGender,
                  //       //           style: const TextStyle(
                  //       //               color: AppColors.secondaryColor,
                  //       //               fontSize: 16),
                  //       //         )),
                  //       //   ),
                  //       // )
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  const SizedBox(height: 15),

                  GetBuilder<AuthController>(builder: (controller)=>Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: ColorApp.secondaryColor,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _authController.register(
                                _nameController.text,
                                _phoneController.text,
                                _passwordController.text,
                                context);
                          }
                          // if (_formKey.currentState!.validate() &&
                          //     _authController.selectedAge != 0 &&
                          //     _authController.selectedGender.isNotEmpty) {
                          //   // _authController.checkUserExists(
                          //   //     _nameController.text,
                          //   //     _phoneController.text,
                          //   //     _passwordController.text,
                          //   //     _authController.selectedAge,
                          //   //     _authController.selectedGender);
                          // } else if (_authController.selectedAge == 0) {
                          //   EasyLoading.showError("Please Select Birthday");
                          // } else if (_authController.selectedGender.isEmpty) {
                          //   EasyLoading.showError("Please Select Gender");
                          // }
                        },
                        child: _authController.apiCallStatus==ApiCallStatus.loading?const ButtonLoaderWidget():Text(
                          "Sign up",
                          style: TextStyle(
                            color: ColorApp.mainColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Or Sign Up With",
                      style: TextStyle(
                        color: ColorApp.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // _authController.signInWithGoogle();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/icons/google.png'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          // _authController.signInWithFacebook();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/icons/facebook.png'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      Get.to(() => LoginView());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: ColorApp.secondaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(Routes.login);
                          },
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: ColorApp.secondaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
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

  bool validateMyanmarPhoneNumber(String value) {
    // Match '09' followed by 7 to 9 digits
    RegExp regex = RegExp(r'^09[0-9]{7,9}$');

    if (!regex.hasMatch(value)) {
      return true; // Invalid phone number
    }

    return false; // Valid phone number
  }
}
