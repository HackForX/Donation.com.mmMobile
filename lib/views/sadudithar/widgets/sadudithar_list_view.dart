import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/views/history/history_view.dart';
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
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: 5, // Fixed number of sections
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return _buildSection(
              context,
              title: 'nearby',
              onSeeAll: () => Get.to(() => SeeMoreSaduditharList(
                    title: tr('nearby'),
                    sadudithars: controller.nearbySadudithars,
                  )),
              child: NearbySaduditharList(controller: controller),
            );
          case 1:
            return _buildCitySection(context);
          case 2:
            return _buildSection(
              context,
              title: 'history',
              onSeeAll: () => Get.to(() => const HistoryView()),
              child: HistoryList(controller: controller),
            );
          case 3:
            return _buildSection(
              context,
              title: 'allSadudithars',
              onSeeAll: () => Get.to(() => SeeMoreSaduditharList(
                    title: tr('allSadudithars'),
                    sadudithars: controller.sadudithars,
                  )),
              child: AllSaduditaharList(controller: controller),
            );
          case 4:
            return _buildSection(
              context,
              title: 'donors',
              onSeeAll: () => Get.to(() => SeeMoreDonorListWidget(
                    donors: controller.donors,
                  )),
              child: DonorList(controller: controller),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required VoidCallback onSeeAll,
    required Widget child,
  }) {
    return Column(
      children: [
        _buildSectionHeader(
          context,
          title: title,
          onSeeAll: onSeeAll,
        ),
        child,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCitySection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'bycity',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Myanmar",
                    ),
              ).tr(),
              CityDropdown(controller: controller),
            ],
          ),
        ),
        CitySaduditharList(controller: controller),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Myanmar",
                ),
          ).tr(),
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'seeall',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorApp.mainColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Myanmar",
                  ),
            ).tr(),
          ),
        ],
      ),
    );
  }
}