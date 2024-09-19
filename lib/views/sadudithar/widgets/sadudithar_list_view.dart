import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/all_sadudithar_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/city_dropdown.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/city_sadudithar_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/donor_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/history_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/nearby_sadudithar_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/see_more_donor_list.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/see_more_sadudithar_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        // Nearby section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20), // Consistent padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "nearby",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Myanmar",
                    ),
              ).tr(),
              InkWell(
                onTap: () => Get.to(
                  () => SeeMoreSaduditharList(
                    title: tr("nearby"),
                    sadudithars: controller.nearbySadudithars,
                  ),
                ),
                child: Text(
                  "seeall",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Myanmar",
                      ),
                ).tr(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        NearbySaduditharList(controller: controller),

        // By City section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20), // Consistent padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "bycity",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Myanmar",
                    ),
              ).tr(),
              CityDropdown(controller: controller),
            ],
          ),
        ),
        const SizedBox(height: 10),
        CitySaduditharList(controller: controller),

        // Donors section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20), // Consistent padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "donors",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Myanmar",
                    ),
              ).tr(),
              InkWell(
                onTap: () => Get.to(
                  () => SeeMoreDonorListWidget(donors: controller.donors),
                ),
                child: Text(
                  "seeall",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Myanmar",
                      ),
                ).tr(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        DonorList(controller: controller),

        // All Sadudithars section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20), // Consistent padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "allSadudithars",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Myanmar",
                    ),
              ).tr(),
              InkWell(
                onTap: () => Get.to(
                  () => SeeMoreSaduditharList(
                    title: tr('allSadudithars'),
                    sadudithars: controller.sadudithars,
                  ),
                ),
                child: Text(
                  "seeall",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Myanmar",
                      ),
                ).tr(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        AllSaduditaharList(controller: controller),

        // History section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20), // Consistent padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "history",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Myanmar",
                    ),
              ).tr(),
              InkWell(
                onTap: () => Get.to(
                  () => SeeMoreSaduditharList(
                    title: tr('allSadudithars'),
                    sadudithars: controller.sadudithars,
                  ),
                ),
                child: Text(
                  "seeall",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Myanmar",
                      ),
                ).tr(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        HistoryList(controller: controller),

        const SizedBox(height: 20), // Slight increase in bottom padding
      ],
    );
  }
}
