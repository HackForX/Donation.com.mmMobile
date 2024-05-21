import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
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
              BoxDecoration(color: const Color.fromARGB(255, 37, 8, 8).withOpacity(0.3)),
          child: controller.sadudithars.isEmpty?EmptyWidget(): SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: controller.sadudithars.map((sadudithar)=>AllSaduditarCard(sadudithar: sadudithar)).toList()),
          ),
        ));
  }
}