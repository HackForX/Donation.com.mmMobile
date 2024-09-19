import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/views/setting/widgets/location_permission_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../util/app_color.dart';
import '../../util/assets_path.dart';

class SettingView extends StatefulWidget {
   const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final AuthController _authController=Get.put(AuthController());

  final HomeController _homeController=Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting"),),
      body: ListView(
        children: [
           
          const LocationToggleScreen(),


    
              
          ListTile(
            onTap: () {
              Get.offAllNamed(Routes.contact);
            },
            leading: Image.asset(
           IconPath.contactIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
              "contact",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
              
          ListTile(
            onTap: () {
              Get.offAllNamed(Routes.guide);
            },
            leading: Image.asset(
     IconPath.guideIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
              "guide",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
            ListTile(
            onTap: () async {
              Share.share(
                  "https://play.google.com/store/apps/details?id=com.donationcommm.foc.app");
            },
            leading: Image.asset(
             IconPath.shareIcon,
              color: ColorApp.mainColor,
              height: 30,
            ),
            title:  Text(
              "share",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr()
          ),
           ListTile(
            onTap: () async {
                Locale currentLocale = context.locale;
                if (currentLocale == const Locale('en','US')) {
                  context.setLocale(const Locale('my', 'MM'));
                   Get.updateLocale(const Locale('my','MM'));
                } else {
                      context.setLocale(const Locale('en', 'US'));
                   Get.updateLocale(const Locale('en','US'));

                }

        
        

            },
            leading:  Icon(Icons.translate,color: ColorApp.mainColor,),
            title:  Text(
             "language",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
       GetBuilder<HomeController>(builder: (controller)=> ListTile(
       leading: Image.asset(
           IconPath.donorIcon,
              color: ColorApp.mainColor,
              height: 20,
            ),
                title: Text(
                  "showProfile",
                  style: TextStyle(
                    color: ColorApp.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ).tr(),
                trailing: Checkbox(
                  value: controller.profile.isShow==1?true:false,
                  onChanged: (bool? newValue) {
           
                    _authController.updateIsShow(context,newValue??false);
                  },
                  activeColor: ColorApp.mainColor, // Optional: set color
                ),
              ),),
          ListTile(
            onTap: () {
              showDeleteAccountDialog(context);
            },
            leading: Image.asset(
           IconPath.trashIcon,
              color: ColorApp.mainColor,
              height: 20,
            ),
            title:  Text(
              "deleteAccount",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
        ],
      ),
    );
  }

  showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Donation.com.mm'),
        content: const Text('deleteAccontMessage').tr(),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('no').tr(),
          ),
          TextButton(
            onPressed: () async {
             _authController.deleteAccount(context);
             

            },
            child: const Text('yes').tr(),
          ),
        ],
      ),
    );
  }
}