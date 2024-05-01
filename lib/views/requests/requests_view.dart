import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/models/natebanay_request_response.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../util/assets_path.dart';



class RequestsView extends GetView<HomeController> {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("ရယူရန်"),
        ),
        body:GetBuilder<HomeController>(builder: (controller)=>ListView.builder(
          itemCount: controller.natebanzaysRequests.length,
          itemBuilder: (BuildContext context, int index) {
            return    RequestedItemCardWidget(
               natebanzayRequest: controller.natebanzaysRequests[index],);
          },
        ),));
  }
}

class RequestedItemCardWidget extends StatelessWidget {
final NatebanzayRequest natebanzayRequest;
  const RequestedItemCardWidget(
      {super.key,
     required this.natebanzayRequest});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
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
                                  "Tecxplorer",
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
                                    Text("ဖိနပ် (1ခု)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: ColorApp.dark,
                                                fontFamily: "Myanmar")),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
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
                                                ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
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
                                                  color:ColorApp.mainColor,
                                                  fontFamily: "English",
                                                ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/comment.png",
                                          color:ColorApp.mainColor,
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
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2.0,
                                  ),
                                  child: Text("အိမ်သုံးပစ္စည်း",
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
                                  child: Text("ရန်ကုန်လှည်းတန်းမြို့နယ်",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: ColorApp.dark,
                                              fontFamily: "Myanmar")),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 10),
                      child: Text(
                          "Size 18 ပဲရှိပါတယ်ဗျ ဖုန်းနံပတ် ၀၉၇၈၃၁၅၀၄ ကို ဆက်သွယ်လိုက်ပါခင်ဗျာ ယူခါနီးကျရင်",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: ColorApp.dark,
                                  fontFamily: "Myanmar")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 10),
                      child: Text("Photos",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: ColorApp.dark,
                                  fontFamily: "English")),
                    ),
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                height: 150,
                                width: 200,
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/photo6.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 150,
                                width: 200,
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/photo6.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 150,
                                width: 200,
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/photo6.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 150,
                                width: 200,
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/photo6.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          )),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorApp.mainColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)))),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Comment"),
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
                                    // Get.to(() => ChatView());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Chat"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                         IconPath.chatIcon,
                                        color: ColorApp.white,
                                        height: 18,
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
      },
      child: Container(
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
              height: 150,
              width: 150,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImagePath.test), fit: BoxFit.cover),
              ),
            ),
            Padding(
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
                  Row(
                    children: [
                      Image.asset(
                     IconPath.dotIcon,
                        color: ColorApp.secondaryColor,
                        height: 14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        natebanzayRequest.status,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontWeight: FontWeight.w300,
                               color: ColorApp.secondaryColor,
                                fontFamily: "Myanmar"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${natebanzayRequest.natebanzay.name} (${natebanzayRequest.natebanzay.quantity.toString()}ခု)",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorApp.dark,
                        fontFamily: "Myanmar"),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Tecxplorer မှ",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: ColorApp.dark,
                        fontFamily: "Myanmar"),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    natebanzayRequest.natebanzay.address,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontFamily: "Myanmar",
                        color: ColorApp.dark,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
