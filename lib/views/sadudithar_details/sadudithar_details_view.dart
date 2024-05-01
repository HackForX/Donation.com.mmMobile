import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:donation_com_mm_v2/views/sadudithar_details/widgets/sadudithar_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';



class SaduditharDetailsView extends StatelessWidget {
  final Sadudithar sadudithar;
  // final String id;
  const SaduditharDetailsView({
    super.key,
    required this.sadudithar
  });

  // final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.getDonationDetails(id);
    //   controller.toggleView(id);
    // });
    return Scaffold(
      drawer:  DrawerView(),
      appBar: AppBar(
        actions: const [
          // ItemDetailsHeartButtonWidget(
          //   controller: controller,
          // )
        ],
        title: const Text("အသေးစိတ်"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        children: [
           SaduditharImageWidget(
            sadudithar: sadudithar,
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
                    "${sadudithar.user.name} မှ လှူဒါန်းသည်",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontFamily: "Myanmar",
                        fontWeight: FontWeight.w600,
                        color: ColorApp.mainColor),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Image.asset(
                    IconPath.likeIcon,
                    color:ColorApp.mainColor,
                    height: 23,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 12),
            child: Text(
              "Dec 12,2023 ${sadudithar.estimatedTime}",
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
                sadudithar.title,
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
                  "1.2K",
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
                  "1K",
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
                  "100",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: ColorApp.dark),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23.0, top: 10),
            child: Text(
              "စတုဒိသာအစီအစဉ်အသေးစိတ် - ၈နာရီမှ ၁၀နာရီထိ ကျွေးမွေးပါမည်",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.w400,
                  color: ColorApp.dark),
            ),
          ),
          const SizedBox(
            height: 30,
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
                          sadudithar.category.name,
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
                         sadudithar.estimatedAmount.toString(),
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
                          sadudithar.address,
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
          Container(
            padding: const EdgeInsets.only(top: 18, left: 15),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
            decoration: const BoxDecoration(color: ColorApp.bgColor),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
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
                            "Dec 12,2023",
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
                            "Nay Yair Linn",
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
                        "ကျေးဇူးအများကြီးတင်ပါသည်ဗျာ လှူဒါန်းပေးလို့ ကျန်းမာပါစေ",
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
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, left: 15),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
            decoration: const BoxDecoration(color: ColorApp.bgColor),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
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
                            "Dec 12,2023",
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
                            "Nyi Ye Lwin",
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
                        "Arigatou gozahmai",
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
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 20),
        child: FloatingActionButton(
            backgroundColor: ColorApp.mainColor,
            onPressed: () {
              // launchMap(
              //     controller.donationDetailsStream.value!.mapAddress ?? '');
              // Get.to(() => const MyMapView());
            },
            child: Image.asset(
              "assets/images/pin.png",
              color: ColorApp.white,
              height: 24,
            )),
      ),
    );
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
