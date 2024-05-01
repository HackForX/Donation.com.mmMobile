import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/dot_indicator.dart';
import 'package:donation_com_mm_v2/util/guide_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../drawer/drawer_view.dart';


class GuideView extends StatefulWidget {
  const GuideView({super.key});

  @override
  State<GuideView> createState() => _GuideViewState();
}

class _GuideViewState extends State<GuideView> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("အသုံးပြုပုံ"),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => GuideItem(
                        image: demoData[index].image,
                      )),
            ),
            const SizedBox(
              height: 15,
            ),
            Positioned(
              bottom: 60,
              right: 20,
              left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: demoData
                    .map((e) => DotIndicator(
                          isActive: demoData.indexOf(e) == _pageIndex,
                        ))
                    .toList(),
              ),
            ),

            // ...List.generate(
            //     demo_data.length,
            //     (index) => DotIndicator(
            //           isActive: index == _pageIndex,
            //         )),
            Positioned(
              bottom: 10,
              right: 20,
              left: 20,
              child: SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: ColorApp.secondaryColor),
                    onPressed: () async {
                      if (_pageIndex != 9) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      } else {
                        Get.back();
                      }
                    },
                    child: Text(
                      _pageIndex != 9 ? "Next" : "Ok,Understand",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ));
  }
}

class Onboard {
  final String image;

  Onboard({
    required this.image,
  });
}

final List<Onboard> demoData = [
  Onboard(
    image: ImagePath.image1,
  ),
  Onboard(
    image:  ImagePath.image2,
  ),
  Onboard(
    image:  ImagePath.image3,
  ),
  Onboard(
    image:  ImagePath.image4
  ),
  Onboard(
    image:  ImagePath.image5
  ),
  Onboard(
    image: ImagePath.image6
  ),
  Onboard(
    image: ImagePath.image7
  ),
  Onboard(
    image:  ImagePath.image8
  ),
  Onboard(
    image: ImagePath.image9
  ),
  Onboard(
    image:  ImagePath.image10
  ),
];