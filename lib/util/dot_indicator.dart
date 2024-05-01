import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:flutter/material.dart';




class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(left: 10),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
          color: isActive
              ? ColorApp.secondaryColor
              : ColorApp.secondaryColor.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
