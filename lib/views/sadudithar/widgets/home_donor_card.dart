import 'package:donation_com_mm_v2/models/donor_response.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/views/donor_details/donor_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeDonorCard extends StatelessWidget {
  final Donor donor;
  const HomeDonorCard({
    super.key, 
    required this.donor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.to(()=>DonorDetailsView(donor: donor)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
                border: Border.all(
                  color: ColorApp.mainColor.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  ImagePath.donor,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              donor.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: "Myanmar",
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 2),
            // Text(
            //   '${donor. ?? 0} ကြိမ်',
            //   style: Theme.of(context).textTheme.labelSmall?.copyWith(
            //     color: ColorApp.mainColor,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}