import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/sadudithar_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'nearby_sadudithar_card.dart';

class NearbySaduditharList extends StatelessWidget {
  final HomeController controller;
  const NearbySaduditharList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>controller.nearbySadudithars.isEmpty?const EmptyWidget():SingleChildScrollView(
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
        ));
  }
}