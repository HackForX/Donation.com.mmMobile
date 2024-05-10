import 'dart:convert';

import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/controllers/request_natebanzay_controller.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/views/natebanzay/widgets/item_natebanzays_list.dart';
import 'package:donation_com_mm_v2/views/natebanzay/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../drawer/drawer_view.dart';

class NateBanZayView extends GetView<HomeController> {
    final RequestNatebanzayController _requestNatebanzayController=Get.put(RequestNatebanzayController()) ;
   NateBanZayView({super.key});



  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async{
        controller.getNatebanzays();
      },
      child: Scaffold(
             floatingActionButton: FloatingActionButton.extended(
            backgroundColor: ColorApp.mainColor,
            elevation: 1,
            onPressed: () {
              Get.toNamed(Routes.createNatebanzay);
            },
            label: Text("ပစ္စည်းလှူမည်",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: ColorApp.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Myanmar")),
            icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                 IconPath.editIcon,
                  height: 22,
                  color: ColorApp.white,
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("နိဗ္ဗာန်စျေး"),
        ),
        body: Obx(()=>ListView(children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("အနီးအနားတွင်ရှိသော",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600, fontFamily: "Myanmar")),
                Text("အားလုံးကြည့်မည်",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Myanmar")),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:controller.natebanzays.map((natebanzay) =>    NatebanzayCard(natebanzay: natebanzay,requestNatebanzayController: _requestNatebanzayController,), ).toList()
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("အမျိုးအစားအလိုက်",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600, fontFamily: "Myanmar")),
                Text("အားလုံးကြည့်မည်",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Myanmar")),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                
                children: controller.items.map((item) =>   InkWell(
                onTap: (){
                  controller.setItem(item);
                },
                child: ItemWidget(
                    name: item.name,
                    isSelected: item==controller.selectedItem,
                  ),
              ), ).toList()),
            ),
          ),
          
      
          const SizedBox(
            height: 10,
          ),
          ItemNatebanzaysList(homeController:controller, requestNatebanzayController: _requestNatebanzayController),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("နေရာအလိုက်",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600, fontFamily: "Myanmar")),
                Text("အားလုံးကြည့်မည်",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Myanmar")),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                   children:controller.natebanzays.map((natebanzay) =>    NatebanzayCard(natebanzay: natebanzay,requestNatebanzayController: _requestNatebanzayController,), ).toList()
            ),
          ),
          const SizedBox(height: 20,),
        ]),)
      ),
    );
  }
}

class NatebanzayCard extends StatelessWidget {
  final Natebanzay natebanzay;
  final RequestNatebanzayController requestNatebanzayController;
  const NatebanzayCard({
    super.key, required this.natebanzay, required this.requestNatebanzayController,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showItemDetailsDialog(context,natebanzay,requestNatebanzayController),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: ColorApp.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 180, 193).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
           natebanzay.photos==null?const SizedBox(
                      height: 150,
                width: 200,
           ): SingleChildScrollView(scrollDirection: Axis.horizontal,child: Container(
                height: 150,
                width: 200,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      10,
                    ),
                    topRight: Radius.circular(
                      10,
                    ),
                  ),
                
                ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: extractPhotos(natebanzay.photos!).map((e) {
                    print("Image $e");
                    return Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Image.network("${AppConfig.baseUrl}/storage/images/natebanzay_photos/$e",height: 100,width: 100,fit: BoxFit.cover ,errorBuilder: (context,object,stack) {
                        print(stack);
                        print(object);
                      
                        return const Icon(Icons.error);
                      },),
                    );
                  }, ).toList(),),
              ),
              ),),
              Positioned(
                right: 20,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: ColorApp.mainColor,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset(
                    IconPath.pinIcon,
                          height: 13,
                          color: ColorApp.white,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "13km",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontFamily: "Myanmar",
                                  color: ColorApp.white,
                                  fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
             natebanzay.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 10),
            child: Text(
             natebanzay.address,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 4),
            child: Text(
              "100views    1.3klikes",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ),
    );
  }

  void showItemDetailsDialog(BuildContext context,Natebanzay natebanzay,RequestNatebanzayController requestNatebanzayController) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 12, bottom: 8, right: 10),
                        child: Column(
                          children: [
                             CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  const AssetImage(ImagePath.profile),
                              backgroundColor: ColorApp.mainColor,
                            ),
                            Text(
                              natebanzay.user!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorApp.dark,
                                      fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("${natebanzay.name} (${natebanzay.quantity.toString()}ခု)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: ColorApp.dark,
                                            fontFamily: "Myanmar")),
                                const SizedBox(
                                  width: 5,
                                ),
                        
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 2.0,
                              ),
                              child: Text(natebanzay.item.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: ColorApp.dark,
                                          fontFamily: "Myanmar")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                              ),
                              child: Text(natebanzay.address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: ColorApp.dark,
                                          fontFamily: "Myanmar")),
                            ),
                            const SizedBox(height: 10,),
                            Row(children: [
                                    Image.asset(
                                  IconPath.viewIcon,
                                      color: ColorApp.mainColor,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("1K",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: ColorApp.mainColor,
                                              fontFamily: "English",
                                            )),
                                const SizedBox(
                                  width: 5,
                                ),
                            Image.asset(
                                    IconPath.likeIcon,
                                      color: ColorApp.mainColor,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("10K",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: ColorApp.mainColor,
                                              fontFamily: "English",
                                            )),
                                const SizedBox(
                                  width: 5,
                                ),
                               Image.asset(
                                    IconPath.commentIcon,
                                      color: ColorApp.mainColor,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("10K",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: ColorApp.mainColor,
                                              fontFamily: "English",
                                            ))
                            ],)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 10),
                  child: Text(
                     natebanzay.note??"",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: ColorApp.dark,
                          fontFamily: "Myanmar")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 10),
                  child: Text("Photos",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: ColorApp.dark,
                          fontFamily: "English")),
                ),
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: natebanzay.photos!=null?extractPhotos(natebanzay.photos??"").map((e) =>   Container(
                            height: 150,
                            width: 200,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(15),
                            decoration:  BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image:NetworkImage("${AppConfig.baseUrl}/storage/images/natebanzay_photos/$e"),
                                  fit: BoxFit.cover),
                            ),
                          ),).toList():[const SizedBox()]
                      )),
                ),
                const Spacer(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorApp.dark,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)))),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Comment",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'English',
                                            color: ColorApp.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                               IconPath.commentIcon,
                                    color: ColorApp.white,
                                    height: 18,
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorApp.mainColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)))),
                              onPressed: () {
                                requestNatebanzayController.request(natebanzay.id, context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Request",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'English',
                                            color: ColorApp.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                  IconPath.natebanzayIcon,
                                    color: ColorApp.white,
                                    height: 20,
                                  ),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
List<String> extractPhotos(String jsonString) {

  final photosWithoutEscape = jsonString.replaceAll('\\', '');

  final photosWithoutBrackets = photosWithoutEscape.substring(2, photosWithoutEscape.length - 2);

  final imageUrls = photosWithoutBrackets.split('","');

  return imageUrls;
}




}
