import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'city_sadudithar_card.dart';



class CitySaduditharList extends StatelessWidget {
  const CitySaduditharList({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    
    return Obx((){
      final filteredSadudithars = controller.sadudithars
      .where((sadudithar) => sadudithar.city.name == controller.selectedCity)
      .toList();
      return filteredSadudithars.isEmpty
      ? controller.sadudithars.isEmpty?const EmptyWidget():SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.sadudithars
                .map((sadudithar) => CitySaduditarCard(sadudithar: sadudithar))
                .toList(),
          ),
        )
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filteredSadudithars
                .map((sadudithar) => CitySaduditarCard(sadudithar: sadudithar))
                .toList(),
          ),
        );
    });
  }
}
