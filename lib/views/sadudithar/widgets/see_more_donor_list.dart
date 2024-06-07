import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/donor_response.dart';
import '../../../util/app_color.dart';
import '../../../util/assets_path.dart';

class SeeMoreDonorListWidget extends StatelessWidget {
  final List<Donor> donors;
  const SeeMoreDonorListWidget({super.key, required this.donors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("donors").tr(),),
      body:     GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.9 ),
            itemCount: donors.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        left: 15,
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                border: Border.all(
                  color:  ColorApp.mainColor,
                  width: 2,
                ),
                shape: BoxShape.circle,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ImagePath.donor))),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(donors[index].name,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w800, fontFamily: "Myanmar")),
          const SizedBox(
            height: 5,
          ),
          Text(donors[index].phone,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w800, fontFamily: "Myanmar")),
        ],
      ),
    ) ;
            },
          )
    );
  }
}