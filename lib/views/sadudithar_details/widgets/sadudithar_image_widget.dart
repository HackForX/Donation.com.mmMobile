import 'package:donation_com_mm_v2/models/sadudithar_response.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:flutter/material.dart';


class SaduditharImageWidget extends StatelessWidget {
  final Sadudithar sadudithar;
  const SaduditharImageWidget({
    super.key, required this.sadudithar,

  });



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorApp.mainColor, width: 0.3),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: double.infinity,
      height: 200,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child:Image.network("${AppConfig.baseUrl}/storage/${sadudithar.image}",fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) => const Icon(Icons.image,size: 30,),)
      ),
    );
  }
}
