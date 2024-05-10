import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShareNatebanzayView extends GetView<HomeController> {
  const ShareNatebanzayView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        controller.getNatebanzaysRequested();
      },
      child: Scaffold(
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("မျှဝေရန်"),
        ),
        body: GetBuilder<HomeController>(builder: (controller){
          return ListView.builder(
            itemCount: controller.natebanzaysRequested.length,
            itemBuilder: (BuildContext context, int index) {
              return  RequestsItemCardWidget(
      natebanzay: controller.natebanzaysRequested[index],
      controller: controller,
            );
            },
            
          );
        },)
      ),
    );
  }
}

class RequestsItemCardWidget extends StatelessWidget {
  final HomeController controller;
  final Natebanzay natebanzay;

  const RequestsItemCardWidget({
    super.key,
    required this.controller,
    required this.natebanzay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: ColorApp.white,
        boxShadow: [
          BoxShadow(
            color: ColorApp.white,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
            width: 170,
            padding: const EdgeInsets.all(15),
            decoration:  BoxDecoration(
              image:
               natebanzay.photos==null?   const DecorationImage(image: AssetImage(ImagePath.test), fit: BoxFit.cover):   DecorationImage(image: NetworkImage("${AppConfig.baseUrl}/storage/images/natebanzay_photos/${extractPhotos(natebanzay.photos!)[0]}"), fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 13.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${natebanzay.name} (${natebanzay.quantity}ခု)",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorApp.dark,
                        fontFamily: "Myanmar"),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${natebanzay.requestedCount.toString()}ဦး မှ တောင်းခံထားသည်",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorApp.dark,
                        fontFamily: "Myanmar"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Image.asset(
                     IconPath.pinIcon,
                        height: 20,
                        width: 20,
                        color: ColorApp.dark,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          natebanzay.address,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontFamily: "Myanmar",
                                  color: ColorApp.dark,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: ()=>Get.toNamed(Routes.viewNatebanzayRequests,arguments: {
                              "natebanzay_id":natebanzay.id
                            }),
                            child: Container(
                                                    padding: const EdgeInsets.only(
                              top: 8, left: 4, right: 4, bottom: 8),
                                                    decoration: BoxDecoration(
                              color: ColorApp.dark.withOpacity(0.9),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                                                    child: Image.asset(
                                        IconPath.viewIcon,
                            
                            height: 20,
                            width: 20,
                            color: ColorApp.white,
                                                    ),
                                                  ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InkWell(
                            onTap: ()=>Get.toNamed(Routes.editNatebanzay,arguments: {
                              "natebanzay":natebanzay
                            }),
                            child: Container(
                                                    padding: const EdgeInsets.only(
                              top: 8, left: 4, right: 4, bottom: 8),
                                                    decoration: BoxDecoration(
                              color: ColorApp.blue.withOpacity(0.9),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                                                    child: Image.asset(
                                                IconPath.editIcon,
                            
                            height: 20,
                            width: 20,
                            color: ColorApp.white,
                                                    ),
                                                  ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InkWell(
                            onTap: (){
                              showDeleteDialog(context, controller,natebanzay.id);
                            },
                            child: Container(
                                                    padding: const EdgeInsets.only(
                              top: 8, left: 4, right: 4, bottom: 8),
                                                    decoration: BoxDecoration(
                              color: ColorApp.lipstick.withOpacity(0.9),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                                                    child: Image.asset(
                                                    IconPath.deleteIcon,
                            height: 20,
                            width: 20,
                            color: ColorApp.white,
                                                    ),
                                                  ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}

void showDeleteDialog(BuildContext context,HomeController controller,int id){
showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Donation.com.mm'),
            content: const Text('ဖျက်ရန်သေချာပီလား?'),
            actions: [
              TextButton(
                onPressed: () =>Get.back(),
                child: const Text('မလုပ်တော့ပါ'),
              ),
              TextButton(
                onPressed: () {
                  controller.deleteNatebanzay(id, context);
                  Get.back();
                },
                child: const Text('လုပ်မည်'),
              ),
            ],
          ),
        );
}

  List<String> extractPhotos(String jsonString) {
  // Parse the JSON string

  // Remove escape sequences (if any)
  final photosWithoutEscape = jsonString.replaceAll('\\', '');

  // Remove leading and trailing quotes and square brackets
  final photosWithoutBrackets = photosWithoutEscape.substring(2, photosWithoutEscape.length - 2);

  // Split the string into a list of image URLs
  final imageUrls = photosWithoutBrackets.split('","');

  return imageUrls;
}


