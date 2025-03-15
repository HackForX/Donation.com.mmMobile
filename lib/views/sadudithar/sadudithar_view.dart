import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/sadudithar_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../routes/app_pages.dart';
import '../../util/app_color.dart';
import '../../util/assets_path.dart';
import '../drawer/drawer_view.dart';



class SaduditharView extends GetView<HomeController> {
  const SaduditharView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorApp.mainColor,
      strokeWidth: 2.5,
      onRefresh: () async {
        // Optimize multiple API calls
        await Future.wait([
          controller.getCities(),
          controller.getDonors(),
          controller.getSadudithars(),
          controller.checkLocationPermission(),
        ]);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: ColorApp.mainColor,
            elevation: 2,
            onPressed: () => _handleFloatingAction(context),
            label: Text(
              "createSadudithar",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ColorApp.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Myanmar",
              ),
            ).tr(),
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                IconPath.editIcon,
                height: 22,
                color: ColorApp.white,
              ),
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        extendBody: true,
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("sadudithar").tr(),
          elevation: 1,
        ),
        body: WillPopScope(
          onWillPop: () => _onWillPop(context),
          child: UpgradeAlert(
            showIgnore: false,
            showLater: false,
            child: SaduditharListView(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }

  void _handleFloatingAction(BuildContext context) {
    if (MySharedPref.getToken() == null) {
      Get.toNamed(Routes.login);
    } else if (Get.find<HomeController>().profile.role == "user") {
      ToastHelper.showErrorToast(
        context, 
        "အလှူရှင်အကောင့်ဖြစ်မှသာ တင်လို့ရပါမည်",
      );
      Get.toNamed(Routes.donorRegister);
    } else if (Get.find<HomeController>().profile.role == "donor") {
      Get.toNamed(Routes.createSadudithar);
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Donation.com.mm'),
        content: const Text('ထွက်မာသေချာပီလား?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'မလုပ်တော့ပါ',
              style: TextStyle(color: ColorApp.mainColor),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorApp.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('လုပ်မည်'),
          ),
        ],
      ),
    ) ?? false;
  }
}