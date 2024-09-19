import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryList extends StatelessWidget {
  final HomeController controller;
  const HistoryList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>Container(
          padding: const EdgeInsets.all(20),
     
          child: controller.historySadudithars.isEmpty?const EmptyWidget(): SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: controller.historySadudithars.map((sadudithar)=>HistoryCard(sadudithar: sadudithar)).toList()),
          ),
        ));
  }
}