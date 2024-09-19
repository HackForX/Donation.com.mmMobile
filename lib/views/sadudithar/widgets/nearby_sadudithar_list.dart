import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:donation_com_mm_v2/views/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_color.dart';
import 'nearby_sadudithar_card.dart';

class NearbySaduditharList extends StatelessWidget {
  final HomeController controller;
  const NearbySaduditharList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      if(controller.isLocationEnabled==false){
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: ColorApp.mainColor,
              child: Image.asset(IconPath.pinIcon,height: 40,color: ColorApp.white,),
            ),
            const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorApp.mainColor,
              foregroundColor: ColorApp.secondaryColor
            ),
            onPressed: (){
              Get.to(()=>SettingView());
            }, child: const Text("Enable Location"))
          ],
        );
      }
      return controller.nearbySadudithars.isEmpty?const EmptyWidget():SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.nearbySadudithars.map((sadudithar) {
            
              if(controller.apiCallStatus==ApiCallStatus.loading){
                return const SizedBox(height: 200,);
              }
           
              return  NearbySaduditarCard(
                sadudithar: sadudithar,
              );
            },).toList()
          ),
        );
    });
  }
}