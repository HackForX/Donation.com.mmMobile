import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/controllers/natebanzay_details_controller.dart';
import 'package:donation_com_mm_v2/controllers/request_natebanzay_controller.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:donation_com_mm_v2/views/natebanzay/%20natebanzay_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemNatebanzaysList extends StatelessWidget {
  final HomeController homeController;
  final RequestNatebanzayController requestNatebanzayController;
  final NatebanzayDetailsController detailsController;
  const ItemNatebanzaysList({super.key, required this.homeController, required this.requestNatebanzayController,required this.detailsController});

  @override
  Widget build(BuildContext context) {
   
    return   Obx((){
             final filteredNataebanzays = homeController.natebanzays
      .where((natebanzay) => natebanzay.item.name == homeController.selectedItem.name)
      .toList();
      return filteredNataebanzays.isEmpty?const EmptyWidget():SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
               children:homeController.natebanzays.map((natebanzay) =>    NatebanzayCard(natebanzay: natebanzay,requestNatebanzayController: requestNatebanzayController,detailsController: detailsController,), ).toList()
          ),
        );
    });
  }
}