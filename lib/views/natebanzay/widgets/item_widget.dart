import 'package:flutter/material.dart';

import '../../../util/app_color.dart';


class ItemWidget extends StatelessWidget {
  final String name;
  final bool isSelected;
  const ItemWidget({
    super.key,
    required this.name,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: isSelected?ColorApp.mainColor:ColorApp.bgColorGrey),
      child: Text(
        name,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.normal,
            color: isSelected?ColorApp.white:ColorApp.dark,
            fontFamily: "Myanmar"),
      ),
    );
  }
}
