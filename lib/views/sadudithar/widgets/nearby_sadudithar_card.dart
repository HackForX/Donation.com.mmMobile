import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/sadudithar_response.dart';
import '../../../util/app_color.dart';
import '../../../util/app_config.dart';

class NearbySaduditarCard extends StatelessWidget {
  final Sadudithar sadudithar;
  const NearbySaduditarCard({
    super.key,
    required this.sadudithar
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Get.toNamed(
          Routes.saduditharDetails,
          arguments: {'sadudithar': sadudithar},
        ),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorApp.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  children: [
                    Hero(
                      tag: 'sadudithar_${sadudithar.id}',
                      child: CachedNetworkImage(
                        imageUrl: "${AppConfig.baseUrl}/storage/${sadudithar.image}",
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ColorApp.mainColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              size: 16,
                              color: ColorApp.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${sadudithar.viewCount}",
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: ColorApp.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: ColorApp.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${sadudithar.likeCount}",
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: ColorApp.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: ColorApp.mainColor,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${DateFormat('MMM d, yyyy').format(DateTime.parse(sadudithar.eventDate))} ${formatTime(sadudithar.actualStartTime)} - ${formatTime(sadudithar.actualEndTime)}",
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: ColorApp.mainColor.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sadudithar.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: "Myanmar",
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: ColorApp.mainColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          sadudithar.township.name,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Myanmar",
                            color: ColorApp.mainColor.withOpacity(0.8),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ColorApp.mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${sadudithar.estimatedQuantity}ဦး",
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontFamily: "Myanmar",
                              color: ColorApp.mainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(String time) {
    final timeParts = time.split(':');
    final dateTime = DateTime(
      2023, 1, 1,
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
    return DateFormat.jm().format(dateTime);
  }
}