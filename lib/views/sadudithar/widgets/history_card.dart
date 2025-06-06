import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/views/sadudithar/widgets/distance_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/sadudithar_response.dart';
import '../../../util/app_color.dart';
import '../../../util/app_config.dart';
import '../../../util/assets_path.dart';


class HistoryCard extends StatelessWidget {
  final Sadudithar sadudithar;
  const HistoryCard({
    super.key,
    required this.sadudithar
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: () => Get.toNamed(Routes.saduditharDetails,arguments: {
        'sadudithar':sadudithar
      }),
      child: Container(
        // height: 250,
        width: 320,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color:  ColorApp.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color.fromARGB(255, 255, 180, 193).withOpacity(0.2),
          //     spreadRadius: 1,
          //     blurRadius: 1,
          //     offset: const Offset(1, 1), // changes position of shadow
          //   ),
          // ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
             Container(
  height: 150,
  width: MediaQuery.of(context).size.width - 100,
  padding: const EdgeInsets.all(15),
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  ),
  child: CachedNetworkImage(
    imageUrl: "${AppConfig.baseUrl}/storage/${sadudithar.image}",
    fit: BoxFit.cover,
    placeholder: (context, url) => const Center(
      child: CircularProgressIndicator(), // Placeholder while the image is loading
    ),
    errorWidget: (context, url, error) =>  ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.asset('assets/images/empty2.png',fit: BoxFit.cover,)),
  ),
),
              sadudithar.latitude!=null&&sadudithar.latitude!=0.0&&sadudithar.longitude!=null&&sadudithar.longitude!=0.0?Positioned(
                right: 20,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color:  ColorApp.mainColor,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset(
                       IconPath.pinIcon,
                          height: 13,
                          color:  ColorApp.white,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        DistanceWidget(latitude: sadudithar.latitude!, longitude: sadudithar.longitude!)
                      ],
                    ),
                  ),
                ),
              ):const SizedBox(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
         "${DateFormat('MMMM d, yyyy').format(DateTime.parse(sadudithar.eventDate))} ${formatTime(sadudithar.actualStartTime)} - ${formatTime(sadudithar.actualEndTime)}",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontFamily: "English", fontWeight: FontWeight.w600),
            ),
          ),
          Container(
                  // constraints: const BoxConstraints(maxWidth: 200),
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
              sadudithar.title ,
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
              
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 4.0, left: 10),
          //   child: Text(
          //     "လှည်းတန်းမြို့နယ်",
          //     style: Theme.of(context)
          //         .textTheme
          //         .bodySmall!
          //         .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 4, bottom: 8),
            child: Text(
              "${sadudithar.estimatedQuantity}ဦး",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color:  ColorApp.dark,
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 4, bottom: 10),
            child: Text(
              sadudithar.township.name,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color:  ColorApp.dark,
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }

  String formatTime(String time) {
    final now = DateTime.now();
    final timeParts = time.split(':');
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(timeParts[0]), // Hours
      int.parse(timeParts[1]), // Minutes
      int.parse(timeParts[2]), // Seconds
    );

    return DateFormat.jm().format(dateTime); // Formats to '6:59 PM'
  }
}
