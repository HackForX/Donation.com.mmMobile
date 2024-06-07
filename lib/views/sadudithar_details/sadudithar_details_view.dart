import 'package:donation_com_mm_v2/controllers/sadudithar_details_controller.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:donation_com_mm_v2/views/sadudithar_details/widgets/sadudithar_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sadudithar/widgets/sadidithar_map_view.dart';



class SaduditharDetailsView extends GetView<SaduditharDetailsController> {



   SaduditharDetailsView({
    super.key,

  });

  final sadudithar=Get.arguments['sadudithar'];

  // final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDetails(sadudithar.id);

      controller.getComments(sadudithar.id);
      controller.view(sadudithar.id, context);
    
    });
 
    return  Scaffold(
      drawer:  DrawerView(),
      appBar: AppBar(
     
        title: const Text("အသေးစိတ်"),
       
      ),
      body:Obx(() {
        if(controller.sadudithar==null){
          return const Center(child: CircularProgressIndicator(),);
        }
        return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        children: [
           SaduditharImageWidget(
            sadudithar: controller.sadudithar!,
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "${controller.sadudithar!.user.name} မှ လှူဒါန်းသည်",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontFamily: "Myanmar",
                        fontWeight: FontWeight.w600,
                        color: ColorApp.mainColor),
                  ),
                ),
              ),
              
           Expanded(
                child: GestureDetector(
                  child: Icon(
                controller.sadudithar!.like!=null?Icons.favorite:Icons.favorite_outline,
                    color:ColorApp.mainColor,
                    size: 23,
                  ),
                  onTap: () {
                    controller.like(sadudithar.id, context);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 12),
            child: Text(
              "${ DateFormat('MMMM d, yyyy').format(DateTime.parse(sadudithar.eventDate))} ${controller.sadudithar!.estimatedTime}",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.w200,
                  color: ColorApp.dark),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                controller.sadudithar!.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontFamily: "Myanmar",
                        fontWeight: FontWeight.w700,
                        color: ColorApp.mainColor),
                  ),
                ),
                const Spacer(),
                Image.asset(
                                      IconPath.viewIcon,
      
                  height: 20,
                  color: ColorApp.dark,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  controller.sadudithar!.viewCount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: ColorApp.dark),
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                                   IconPath.commentIcon,
      
                  height: 18,
                  color: ColorApp.dark,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
               controller.sadudithar!.commentCount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: ColorApp.dark),
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
               IconPath.heartIcon,
                  height: 18,
                  color: ColorApp.dark,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
              controller.sadudithar!.likeCount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: ColorApp.dark),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23.0, top: 10),
            child: Text(
            controller.sadudithar!.description??"",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.w400,
                  color: ColorApp.dark),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
   Obx(()=>         controller.sadudithar!.latitude!=null||controller.sadudithar!.longitude!=null?  InkWell(
    onTap:() {
      Get.to(()=>SaduditharMapView(latitude: controller.sadudithar!.latitude, longitude:controller.sadudithar!.longitude));
    },
     child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                decoration: BoxDecoration(
                  color: ColorApp.mainColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                children: [
                   Text("မြေပုံကြည့်မည်",style: TextStyle(color: ColorApp.secondaryColor,fontWeight: FontWeight.w700,fontSize: 14),),
                   const Spacer()
     ,             Icon(Icons.map,color:ColorApp.secondaryColor)
                ],
                          ),
              ),
   ):const SizedBox(),),
               const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorApp.mainColor)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "လှူဖွယ်",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 8,
                            fontFamily: "Myanmar",
                            fontWeight: FontWeight.bold,
                            color: ColorApp.mainColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                          controller.sadudithar!.category.name,
                          style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: "Myanmar",
                                    fontWeight: FontWeight.w500,
                                    color: ColorApp.mainColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorApp.mainColor)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "အရေအတွက်",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 8,
                            fontFamily: "Myanmar",
                            fontWeight: FontWeight.bold,
                            color: ColorApp.mainColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                         controller.sadudithar!.estimatedQuantity.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontSize: 14,
                                  fontFamily: "Myanmar",
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: ColorApp.mainColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorApp.mainColor)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "နေရာ",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 8,
                            fontFamily: "Myanmar",
                            fontWeight: FontWeight.bold,
                            color: ColorApp.mainColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          controller.sadudithar!.address,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontSize: 14,
                                  fontFamily: "Myanmar",
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: ColorApp.mainColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15),
            child: Text(
              "မှတ်ချက်များ",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: "Myanmar",
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ListView.builder(
      itemCount:controller.comments.length<5?controller.comments.length:5 ,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        return        Container(
            padding: const EdgeInsets.only(top: 18, left: 15),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
            decoration: const BoxDecoration(color: ColorApp.bgColor),
            child: Row(
              children: [
                 const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(ImagePath.profile),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                             
                            DateFormat('MMM d, y').format(DateTime.parse( controller.comments[index].createdAt))   ,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorApp.dark,
                                    fontFamily: "English"),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                           controller.comments[index].user.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorApp.dark,
                                    fontFamily: "English"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                       controller.comments[index].comment,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorApp.dark,
                            fontFamily: "English"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
      },
          )
          
        ],
      );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 20),
        child: FloatingActionButton(
            backgroundColor: ColorApp.mainColor,
            onPressed: () {
              Get.toNamed(Routes.saduditharComments,arguments: {
                'sadudithar_id':sadudithar.id,
              });
            },
            child: Image.asset(
        IconPath.commentIcon,
              color: ColorApp.white,
              height: 24,
            )),
      ),
    );
  }

  Future<void> launchGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  launchMap(String url) async {
    // const url = 'https://maps.app.goo.gl/xgWdBiynUnzWAJZK9';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      EasyLoading.showError("Can't launch map ");
    }
  }

  String extractSrcValueFromIframe(String iframeHtml) {
    final document = parse(iframeHtml);
    final iframeElement = document.querySelector('iframe');

    // Check if iframe element exists and has a src attribute
    if (iframeElement != null && iframeElement.attributes.containsKey('src')) {
      return iframeElement.attributes['src']!;
    }

    return 'Src value not found';
  }
}
