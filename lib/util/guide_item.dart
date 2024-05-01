import 'package:flutter/material.dart';

class GuideItem extends StatelessWidget {
  final String image;

  const GuideItem(
      {Key? key,
      required this.image,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
