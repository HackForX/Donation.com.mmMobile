import 'package:flutter/material.dart';

class GuideItem extends StatelessWidget {
  final String image;

  const GuideItem(
      {super.key,
      required this.image,
     });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:80.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          image,
          height: 300,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
