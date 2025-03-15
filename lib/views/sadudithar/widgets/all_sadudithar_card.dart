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

// class AllSaduditarCard extends StatelessWidget {
//   final Sadudithar sadudithar;
//   const AllSaduditarCard({
//     super.key,
//     required this.sadudithar
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: 'sadudithar_${sadudithar.id}',
//       child: Card(
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(15),
//           onTap: () => Get.toNamed(
//             Routes.saduditharDetails,
//             arguments: {'sadudithar': sadudithar}
//           ),
//           child: SizedBox(
//             width: 320,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildImageSection(context),
//                 _buildContentSection(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImageSection(BuildContext context) {
//     return Stack(
//       children: [
//         ClipRRect(
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//           child: CachedNetworkImage(
//             imageUrl: "${AppConfig.baseUrl}/storage/${sadudithar.image}",
//             height: 180,
//             width: double.infinity,
//             fit: BoxFit.cover,
//             memCacheHeight: 360,
//             memCacheWidth: 640,
//             placeholder: (context, url) => Container(
//               color: Colors.grey[100],
//               child: const Center(
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                 ),
//               ),
//             ),
//             errorWidget: (context, url, error) => Container(
//               color: Colors.grey[50],
//               child: Center(
//                 child: Image.asset(
//               'assets/images/empty2.png',
//                   // height: 65,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (_hasValidLocation)
//           Positioned(
//             right: 12,
//             top: 12,
//             child: _buildDistanceChip(),
//           ),
//       ],
//     );
//   }

//  Widget _buildContentSection(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: ColorApp.mainColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 sadudithar.category.name,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   color: ColorApp.mainColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Icon(Icons.location_on_outlined, 
//               size: 16, color: Colors.grey[600]),
//             const SizedBox(width: 4),
//             Text(
//               sadudithar.township.name,
//               style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                 color: Colors.grey[600],
//                 fontFamily: "Myanmar",
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Text(
//           sadudithar.title,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//             fontFamily: "Myanmar",
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 12),
//         _buildDateTimeRow(context),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildQuantityChip(context),
//             Row(
//               children: [
//                 Icon(Icons.favorite_outline, 
//                   size: 16, color: Colors.grey[600]),
//                 const SizedBox(width: 4),
//                 Text(
//                   '${sadudithar.likeCount}',
//                   style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Icon(Icons.chat_bubble_outline, 
//                   size: 16, color: Colors.grey[600]),
//                 const SizedBox(width: 4),
//                 Text(
//                   '${sadudithar.commentCount}',
//                   style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }






class AllSaduditarCard extends StatelessWidget {
  final Sadudithar sadudithar;
  const AllSaduditarCard({super.key, required this.sadudithar});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 600 ? screenWidth * 0.85 : 320.0;
    
    return Hero(
      tag: 'sadudithar_${sadudithar.id}',
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
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
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
                  ImagePath.logo,
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
        if (_hasValidLocation)
          Positioned(
            right: 12,
            top: 12,
            child: _buildDistanceChip(),
          ),
        Positioned(
          left: 12,
          bottom: 12,
          child: _buildCategoryChip(context),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        sadudithar.category.name,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: ColorApp.mainColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  


  Widget _buildDistanceChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            IconPath.pinIcon,
            height: 12,
            color: ColorApp.white,
          ),
          const SizedBox(width: 4),
          DistanceWidget(
            latitude: sadudithar.latitude!,
            longitude: sadudithar.longitude!,
          ),
        ],
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
              Icon(Icons.location_on_outlined, 
                size: 16, color: ColorApp.mainColor),
              const SizedBox(width: 4),
              Text(
                '${sadudithar.city.name}, ${sadudithar.township.name}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.grey[700],
                  fontFamily: "Myanmar",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            sadudithar.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: "Myanmar",
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          _buildDateTimeRow(context),
          const SizedBox(height: 12),
          _buildFooterRow(context),
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

  Widget _buildFooterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildQuantityChip(context),
        Row(
          children: [
            _buildStatChip(
              context,
              Icons.favorite_outline,
              sadudithar.likeCount.toString(),
            ),
            const SizedBox(width: 16),
            _buildStatChip(
              context,
              Icons.chat_bubble_outline,
              sadudithar.commentCount.toString(),
            ),
          ],
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


  Widget _buildStatChip(BuildContext context, IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 16, color: ColorApp.mainColor),
        const SizedBox(width: 4),
        Text(
          count,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: ColorApp.mainColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
    bool get _hasValidLocation =>
    sadudithar.latitude != null &&
    sadudithar.latitude != 0.0 &&
    sadudithar.longitude != null &&
    sadudithar.longitude != 0.0;

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