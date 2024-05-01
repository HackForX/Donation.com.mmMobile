import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/all_sadudithar_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllSaduditaharList extends StatelessWidget {
  final HomeController controller;
  const AllSaduditaharList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>Container(
          padding: const EdgeInsets.all(20),
          decoration:
              BoxDecoration(color: ColorApp.kDarkGray.withOpacity(0.3)),
          child:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: controller.sadudithars.map((sadudithar)=>AllSaduditarCard(sadudithar: sadudithar)).toList()),
          ),
        ));
  }
}