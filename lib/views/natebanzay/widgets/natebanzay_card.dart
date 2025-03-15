import 'package:donation_com_mm_v2/views/natebanzay/%20natebanzay_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controllers/natebanzay_details_controller.dart';
import '../../../controllers/request_natebanzay_controller.dart';
import '../../../models/natebanzay_response.dart';
import '../../../util/app_color.dart';
import '../../../util/app_config.dart';
import '../../share_natebanzay/share_natebanzay_view.dart';

class NatebanzayCard extends StatelessWidget {
  final Natebanzay natebanzay;
  final RequestNatebanzayController requestNatebanzayController;
  final NatebanzayDetailsController detailsController;

  const NatebanzayCard({
    super.key,
    required this.natebanzay,
    required this.requestNatebanzayController,
    required this.detailsController,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.width * 0.4;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            detailsController.getDetails(natebanzay.id);
            detailsController.view(natebanzay.id);
            showItemDetailsDialog(context, detailsController, requestNatebanzayController);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: imageHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImageSection(imageHeight),
                    _buildGradientOverlay(),
                    _buildActionButtons(),
                    _buildPhotoCount(),
                  ],
                ),
              ),
              _buildContentSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Positioned(
      top: 12,
      right: 12,
      child: _buildIconButton(
        icon: Icons.favorite_rounded,
        isActive: natebanzay.like != null,
        onTap: () => detailsController.like(natebanzay.id),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive ? ColorApp.mainColor : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCount() {
    if (natebanzay.photos == null) return const SizedBox.shrink();
    
    return Positioned(
      bottom: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.photo_library_rounded, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(
              extractPhotos(natebanzay.photos!).length.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(double height) {
    if (natebanzay.photos == null) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorApp.mainColor.withOpacity(0.05),
              Colors.grey.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_outlined,
                color: ColorApp.mainColor.withOpacity(0.3),
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                'No images available',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PageView.builder(
      itemCount: extractPhotos(natebanzay.photos!).length,
      itemBuilder: (context, index) {
        final photo = extractPhotos(natebanzay.photos!)[index];
        return Hero(
          tag: 'natebanzay_${natebanzay.id}_$index',
          child: Image.network(
            "${AppConfig.baseUrl}/storage/images/natebanzay_photos/$photo",
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildErrorImage(),
          ),
        );
      },
    );
  }

  Widget _buildErrorImage() {
    return Container(
      color: Colors.grey.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_rounded,
            color: ColorApp.mainColor.withOpacity(0.3),
            size: 48,
          ),
          const SizedBox(height: 8),
          Text(
            'Image not available',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
            stops: const [0.0, 0.6],
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            natebanzay.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: "Myanmar",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: padding * 0.5),
          _buildAddressRow(context),
          SizedBox(height: padding * 0.75),
          _buildStatsRow(context),
        ],
      ),
    );
  }

  Widget _buildAddressRow(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ColorApp.mainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.location_on_rounded,
            size: 14,
            color: ColorApp.mainColor,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            natebanzay.address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
              fontFamily: "Myanmar",
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem(
          context: context,
          icon: Icons.remove_red_eye_rounded,
          value: natebanzay.viewCount.toString(),
          label: 'Views',
        ),
        _buildStatItem(
          context: context,
          icon: Icons.favorite_rounded,
          value: natebanzay.likeCount.toString(),
          label: 'Likes',
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorApp.mainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 16,
            color: ColorApp.mainColor,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ColorApp.mainColor,
                fontWeight: FontWeight.w600,
                fontFamily: "English",
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<String> extractPhotos(String jsonString) {
  try {
    // Handle empty or null string
    if (jsonString.isEmpty) {
      return [];
    }

    // Remove escape sequences and whitespace
    final cleanString = jsonString.replaceAll('\\', '').trim();

    // Remove leading/trailing brackets and quotes
    final strippedString = cleanString
        .replaceAll(RegExp(r'^\["|"\]$'), '')
        .replaceAll(RegExp(r'^"|"$'), '');

    // Split the string into array and filter empty entries
    final imageUrls = strippedString
        .split('","')
        .where((url) => url.isNotEmpty)
        .toList();

    return imageUrls;
  } catch (e) {
    print('Error extracting photos: $e');
    return [];
  }
}
}