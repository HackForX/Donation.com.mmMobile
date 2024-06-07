import 'package:donation_com_mm_v2/models/donor_response.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:flutter/material.dart';


class HomeDonorCard extends StatelessWidget {
  final Donor donor;
  const HomeDonorCard({
    super.key, required this.donor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        left: 15,
      ),
      child: Column(
        children: [
          Container(
height: 100,
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
          Text(donor.name,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w800, fontFamily: "Myanmar")),
          const SizedBox(
            height: 5,
          ),
          //  Text(donor.,
          //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
          //         fontWeight: FontWeight.w800, fontFamily: "Myanmar")),
          // Text("1ကြိမ်",
          //     style: Theme.of(context).textTheme.labelLarge!.copyWith(
          //         fontWeight: FontWeight.w800, fontFamily: "Myanmar")),
        ],
      ),
    );
  }
}