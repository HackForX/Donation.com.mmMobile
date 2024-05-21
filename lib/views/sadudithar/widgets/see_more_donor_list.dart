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
      appBar: AppBar(title: const Text("Donors"),),
      body: ListView.builder(
        itemCount: donors.length,
        itemBuilder: (BuildContext context, int index) {
          return  GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.5 ),
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
                    image: AssetImage(ImagePath.profile))),
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
          Text("1ကြိမ်",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w800, fontFamily: "Myanmar")),
        ],
      ),
    ) ;
            },
          );
        },
      ),
    );
  }
}