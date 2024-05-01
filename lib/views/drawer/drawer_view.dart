import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:share_plus/share_plus.dart';

class DrawerView extends StatelessWidget {
   DrawerView({super.key});
  final AuthController _authController=Get.put(AuthController())  ;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 100,
            decoration:  BoxDecoration(color: ColorApp.mainColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImagePath.logo),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Donation.com.mm",
                      style: TextStyle(
                          color: ColorApp.white,
                          fontSize: 18,
                          fontFamily: "English",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text(
                  "v1.1",
                  style: TextStyle(
                      color: ColorApp.white,
                      fontSize: 13,
                      fontFamily: "English",
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.offAllNamed(Routes.main);
            },
            leading: Image.asset(
              IconPath.homeIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
              "ပင်မစာမျက်နှာ",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () => Get.offAllNamed(Routes.notification),
            leading: Image.asset(
         IconPath.notiIcon,
              color: ColorApp.mainColor,
              height: 25,
            ),
            title:  Text(
              "အသိပေးချက်",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              // Get.offAll(() => const HistoryView());
            },
            leading: Image.asset(
              IconPath.historyIcon,
              color: ColorApp.mainColor,
              height: 26,
            ),
            title:  Text(
              "လှူဒါန်းမှုမှတ်တမ်း",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              Get.offAllNamed(Routes.contactInfo);
            },
            leading: Image.asset(
           IconPath.contactIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
              "ဆက်သွယ်ရန်",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
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
              "အသုံးပြုပုံ",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () async {
              Share.share(
                  "https://play.google.com/store/apps/details?id=com.focsaduditar.app");
            },
            leading: Image.asset(
             IconPath.shareIcon,
              color: ColorApp.mainColor,
              height: 30,
            ),
            title:  Text(
              "မျှဝေရန်",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () async {
              Get.offAllNamed(Routes.donorRegister);

            },
            leading: Image.asset(
         IconPath.donorIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
              "အလှူရှင်စာရင်းသွင်းမည်",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () async {
              showLogoutDialog(context);
            },
            leading: Image.asset(
              IconPath.logoutIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
              "ထွက်မည်",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Donation.com.mm'),
        content: const Text('အကောင့်မှထွက်မာသေချာပီလား?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('မလုပ်တော့ပါ'),
          ),
          TextButton(
            onPressed: () async {
             _authController.logout(context);
             

            },
            child: const Text('လုပ်မည်'),
          ),
        ],
      ),
    );
  }
}
