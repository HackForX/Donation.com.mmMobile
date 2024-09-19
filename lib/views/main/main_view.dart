import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/views/natebanzay/%20natebanzay_view.dart';
import 'package:donation_com_mm_v2/views/sadudithar/sadudithar_view.dart';
import 'package:donation_com_mm_v2/views/share_natebanzay/share_natebanzay_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/custom_menu_controller.dart';
import '../get_natebanzay/get_natebanzays_view.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final CustomMenuController controller = Get.put(CustomMenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: PageStorage(bucket: bucket, child: menuController.currentScreen),
      

      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children:   [
            // HomeAppBarWidget(),
            const SaduditharView(),
            // const HistoryView(),
            NateBanZayView(),
           const GetNatebanzaysView(),
        const ShareNatebanzayView(),

          ],
        ),
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          backgroundColor:ColorApp.mainColor,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:ColorApp.white,
          selectedLabelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Myanmar",
              fontSize: 14.sp),
          unselectedLabelStyle: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w400,
              fontFamily: "Myanmar",
              fontSize: 14.sp),
          selectedItemColor:ColorApp.secondaryColor,
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset(
                IconPath.homeIcon,
                  height: 24,
                  color: ColorApp.secondaryColor,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset( IconPath.homeIcon,
                    height: 24, color: ColorApp.white,),
              ),
              label: tr('sadudithar'),
            ),
           
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset(
               IconPath.natebanzayIcon,
                  height: 24,
                  color:ColorApp.secondaryColor,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset( IconPath.natebanzayIcon,
                    height: 24, color: ColorApp.white),
              ),
              label: tr('natebanzay'),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset(
               IconPath.requestsIcon,
                  height: 24,
                  color: ColorApp.secondaryColor,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset(
                 IconPath.requestsIcon,
                  height: 24,
                  color: ColorApp.white.withOpacity(0.7),
                ),
              ),
              label: tr('requested'),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset(
                  IconPath.listIcon,
                  height: 24,
                  color: ColorApp.secondaryColor,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                child: Image.asset(
             IconPath.listIcon,
                  height: 24,
                  color: ColorApp.white.withOpacity(0.7),
                ),
              ),
              label:  tr('requests'),
            ),
          ],
        ),
      ),
    );
  }
}
