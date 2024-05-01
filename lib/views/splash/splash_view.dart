import 'package:donation_com_mm_v2/controllers/splash_controller.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';



class SplashView extends StatelessWidget {
  SplashView({super.key});

  @override
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
   return GetBuilder<SplashController>(
        builder: (controller) =>Scaffold(
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                          ImagePath.logo,
                            height: 120,
                          ),
                        ),
                     
               
                  ],
                ),
              ),
            ));
  }
}
