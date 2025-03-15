import 'package:donation_com_mm_v2/controllers/auth_controller.dart';
import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/views/drawer/version_widget.dart';
import 'package:donation_com_mm_v2/views/setting/setting_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:share_plus/share_plus.dart';

class DrawerView extends GetView<HomeController> {
   DrawerView({super.key});
  final AuthController _authController=Get.put(AuthController())  ;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(()=>ListView(
        children: [
          Container(
            height: 220,
            decoration:  BoxDecoration(color: ColorApp.mainColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 6,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // height: 40,
                        height: 80,
                        width: 100,
                        decoration:  const BoxDecoration(
                  
                            image: DecorationImage(
                              
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.fitHeight)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [ 
                           Text(
                            "Donation.com.mm",
                            style: TextStyle(
                                color: ColorApp.secondaryColor,
                                fontSize: 18,
                                fontFamily: "English",
                                fontWeight: FontWeight.bold),
                                                 ),
                                                   const VersionWidget(),
                         ],
                       ),
                    
                    ],
                  ),
                ),
  Padding(padding: const EdgeInsets.only(left: 13,bottom: 5,),child: Text(controller.profile.name,style:  TextStyle(
                              color: ColorApp.secondaryColor,
                              fontSize: 14,
                              fontFamily: "English",
                              fontWeight: FontWeight.w400),),
                            ),
                            Padding(padding: const EdgeInsets.only(left: 13,bottom: 5),child:   Text(controller.profile.role.toUpperCase(),style:  TextStyle(
                              color: ColorApp.secondaryColor,
                              fontSize: 14,
                              fontFamily: "English",
                          
                              fontWeight: FontWeight.w400),),),
     

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
              "home",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
          ListTile(
            onTap: () => MySharedPref.getToken()==null?Get.toNamed(Routes.login):Get.offAllNamed(Routes.notification),
            leading: Image.asset(
         IconPath.notiIcon,
              color: ColorApp.mainColor,
              height: 25,
            ),
            title:  Text(
              "notification",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
          ListTile(
            onTap: () {
                 Get.offAllNamed(Routes.history);

            },
            leading: Image.asset(
              IconPath.historyIcon,
              color: ColorApp.mainColor,
              height: 26,
            ),
            title:  Text(
              "history",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
     
        
          controller.profile.role=='user'?ListTile(
            onTap: () async {
              Get.offAllNamed(Routes.donorRegister);

            },
            leading: Image.asset(
         IconPath.donorIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
             "donorRegister",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ):const SizedBox(),
          ListTile(
            onTap: ()  {
           Get.to(()=> const SettingView());
            },
            leading: Image.asset(
              IconPath.settingIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
              "setting",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
          ListTile(
            onTap: () async {
              if(MySharedPref.getToken()==null&&MySharedPref.getUserId()==null){
                Get.toNamed(Routes.login);
              }else{
                        showLogoutDialog(context);
              }
            },
            leading: Image.asset(
              IconPath.logoutIcon,
              color: ColorApp.mainColor,
              height: 24,
            ),
            title:  Text(
           MySharedPref.getToken()==null&&MySharedPref.getUserId()==null?"login":   "logout",
              style: TextStyle(
                  color: ColorApp.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ).tr(),
          ),
        ],
      )),
    );
  }

  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Donation.com.mm'),
        content: const Text('logoutMessage').tr(),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('no').tr(),
          ),
          TextButton(
            onPressed: () async {
             _authController.logout(context);
             

            },
            child: const Text('yes').tr(),
          ),
        ],
      ),
    );
  }
}
