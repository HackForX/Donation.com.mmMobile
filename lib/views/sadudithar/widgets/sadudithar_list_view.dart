import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/models/donor_response.dart';
import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/empty_widget.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/all_sadudithar_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/city_dropdown.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/city_sadudithar_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/donor_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/nearby_sadudithar_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/sadudithar_search_box.dart';
import 'package:donation_com_mm_v2/views/sadudithar_details/sadudithar_details_view.dart';
import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'all_sadudithar_card.dart';


class SaduditharListView extends StatelessWidget {
  const SaduditharListView({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {

    
   return ListView(
      children: [
        const SaduditharSearchBoxWidget(),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("အနီးအနားတွင်ရှိသော",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, fontFamily: "Myanmar")),
              Text("အားလုံးကြည့်မည်",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color:  ColorApp.dark,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Myanmar")),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        NearbySaduditharList(controller: controller),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("မြို့အလိုက်",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, fontFamily: "Myanmar")),
              
            CityDropdown(controller: controller),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CitySaduditharList(controller: controller),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("အလှူရှင်များ",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, fontFamily: "Myanmar")),
              Text("အားလုံးကြည့်မည်",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: ColorApp.dark,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Myanmar")),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
         DonorList(controller: controller),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("အလှူအားလုံး",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, fontFamily: "Myanmar")),
              Text("အားလုံးကြည့်မည်",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color:  ColorApp.dark,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Myanmar")),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
           AllSaduditaharList(controller: controller),
        const SizedBox(
          height: 15,
        ),
    
      ],
    );
  }
}
