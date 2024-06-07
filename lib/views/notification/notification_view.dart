import 'package:donation_com_mm_v2/controllers/notification_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../drawer/drawer_view.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("notification").tr(),
        ),
        body:Obx(()=>Container(
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                  ),
                  child: ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(controller.notifications.isEmpty){
                        return const Center(child: Text("အသိပေးချက်များမရှိသေးပါ"),);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.all(10),
                          // leading: CircleAvatar(
                          //     backgroundColor: primaryColor.withOpacity(0.9),
                          //     child: AppConstants.notiIcon),
                          subtitle:  Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                               controller.notifications[index].body,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                 Text(
                                DateFormat('MMM d, y').format(DateTime.parse( controller.notifications[index].createdAt))   ,
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title:  Text(
                                                         controller.notifications[index].title,

                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                )));
  }
}
