import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/sadudithar_response.dart';
import '../../../util/app_color.dart';
import '../../../util/app_config.dart';

class CitySaduditarCard extends StatelessWidget {
  final Sadudithar sadudithar;
  const CitySaduditarCard({
    super.key, 
    required this.sadudithar,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 600 ? screenWidth * 0.85 : 320.0;
    
    return Hero(
      tag: 'city_sadudithar_${sadudithar.id}',
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: cardWidth,
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: 8,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Get.toNamed(
              Routes.saduditharDetails,
              arguments: {'sadudithar': sadudithar}
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _buildImageSection(context),
                ),
                _buildContentSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: "${AppConfig.baseUrl}/storage/${sadudithar.image}",
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[50],
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ColorApp.mainColor,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[50],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty2.png',
                    height: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Image not available',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: _buildCityChip(context),
        ),
      ],
    );
  }

  Widget _buildCityChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ColorApp.mainColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        sadudithar.city.name,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: ColorApp.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

 Widget _buildContentSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ColorApp.mainColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                sadudithar.category.name,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: ColorApp.mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.location_on_outlined, 
              size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              sadudithar.township.name,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.grey[600],
                fontFamily: "Myanmar",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          sadudithar.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: "Myanmar",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildDateTimeRow(context),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuantityChip(context),
            Row(
              children: [
                Icon(Icons.favorite_outline, 
                  size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${sadudithar.likeCount}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.chat_bubble_outline, 
                  size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${sadudithar.commentCount}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _buildDateTimeRow(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 14,
          color: ColorApp.dark.withOpacity(0.7),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            "${DateFormat('MMMM d, yyyy').format(DateTime.parse(sadudithar.eventDate))} ${_formatTime(sadudithar.actualStartTime)} - ${_formatTime(sadudithar.actualEndTime)}",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: ColorApp.dark.withOpacity(0.7),
              fontFamily: "English",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: ColorApp.mainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${sadudithar.estimatedQuantity}ဦး",
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: ColorApp.mainColor,
          fontFamily: "Myanmar",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatTime(String time) {
    final timeParts = time.split(':');
    final dateTime = DateTime(
      2024, 1, 1,
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
    return DateFormat.jm().format(dateTime);
  }
}