import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/all_sadudithar_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllSaduditaharList extends StatelessWidget {
  final HomeController controller;
  const AllSaduditaharList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sadudithars = controller.sadudithars;
      
      if (sadudithars.isEmpty) {
        return const EmptyWidget();
      }

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        height: 380, // Fixed height for better performance
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: sadudithars.length,
          cacheExtent: 3, // Cache 3 items ahead
          itemBuilder: (context, index) => AllSaduditarCard(
            key: ValueKey('sadudithar_${sadudithars[index].id}'),
            sadudithar: sadudithars[index],
          ),
        ),
      );
    });
  }
}