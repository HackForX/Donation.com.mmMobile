import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../drawer/drawer_view.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("အသိပေးချက်များ"),
        ),
        body:Container(
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                  ),
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
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
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                               "Test Notification",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                 "12/2/33",
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                          "Test Title",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ));
  }
}
