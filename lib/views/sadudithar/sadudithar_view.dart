import 'package:donation_com_mm_v2/controllers/home_controller.dart';
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
      onRefresh: () async {
        controller.getCities();
      controller.getDonors();
        controller.getSadudithars();
        controller.checkLocationPermission();


      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorApp.mainColor,
          elevation: 1,
          onPressed: () {
            if(Get.find<HomeController>().profile.role=="user"){
            ToastHelper.showErrorToast(context, "အလှူရှင်အကောင့်ဖြစ်မှသာ တင်လို့ရပါမည်");
            Get.toNamed(Routes.donorRegister);
            }else if (Get.find<HomeController>().profile.role=="donor"){
                 Get.toNamed(Routes.createSadudithar);
            }
          },
          label: Text("createSadudithar",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: ColorApp.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Myanmar")).tr(),
          icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
               IconPath.editIcon,
                height: 22,
                color: ColorApp.white,
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,
          drawer:  DrawerView(),
          appBar: AppBar(
            title: const Text("sadudithar").tr(),
          ),
          body: WillPopScope(
              onWillPop: () => _onWillPop(context),
              child: UpgradeAlert(
                showIgnore: false,
                showLater: false,
                child: SaduditharListView(
                  controller: controller,
                ),
              ))),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Donation.com.mm'),
            content: const Text('ထွက်မာသေချာပီလား?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('မလုပ်တော့ပါ'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('လုပ်မည်'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
