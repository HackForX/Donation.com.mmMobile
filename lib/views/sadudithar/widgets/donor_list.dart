import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/home_donor_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DonorList extends StatelessWidget {
  const DonorList({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {

    return Obx(()=>controller.donors.isEmpty?const SizedBox(
       height: 120,
            width: 120,
      child: Center(child: Text("အလှူရှင်များမရှိသေးပါ"),)):SingleChildScrollView(
     scrollDirection: Axis.horizontal,
     child: Row(children: controller.donors.map((donor) =>  HomeDonorCard(donor: donor,)).toList()),
            ));
  }
}