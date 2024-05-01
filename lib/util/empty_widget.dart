import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:flutter/material.dart';



class EmptyWidget extends StatelessWidget {

  const EmptyWidget({super.key, });

  @override
  Widget build(BuildContext context) {
    return  Center(child: Image.asset(ImagePath.empty,height: 200,width: 190,fit: BoxFit.cover,));
  }
}
