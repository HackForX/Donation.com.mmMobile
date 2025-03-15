import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/controllers/natebanzay_details_controller.dart';
import 'package:donation_com_mm_v2/controllers/request_natebanzay_controller.dart';
import 'package:donation_com_mm_v2/core/api_call_status.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';

import 'package:donation_com_mm_v2/views/natebanzay/widgets/item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/toast_helper.dart';
import '../drawer/drawer_view.dart';
import '../share_natebanzay/share_natebanzay_view.dart';
import 'see_more_natebanzay_list_widget.dart';
import 'widgets/natebanzay_card.dart';



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

  void showItemDetailsDialog(BuildContext context, NatebanzayDetailsController detailsController, RequestNatebanzayController requestNatebanzayController) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Obx(() {
          if (detailsController.apiCallStatus == ApiCallStatus.loading || 
              detailsController.natebanzay == null) {
            return const FractionallySizedBox(
              heightFactor: 0.9,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with user info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade100),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: const AssetImage(ImagePath.donor),
                        backgroundColor: ColorApp.mainColor.withOpacity(0.1),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detailsController.natebanzay!.user!.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Myanmar",
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${detailsController.natebanzay!.name} (${detailsController.natebanzay!.quantity}ခု)",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                                fontFamily: "Myanmar",
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          detailsController.natebanzay!.like != null 
                              ? Icons.favorite 
                              : Icons.favorite_outline,
                          color: ColorApp.mainColor,
                        ),
                        onPressed: () => detailsController.like(detailsController.natebanzay!.id),
                      ),
                    ],
                  ),
                ),

                // Stats row
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context: context,
                        icon: IconPath.viewIcon,
                        value: detailsController.natebanzay!.viewCount.toString(),
                        label: 'Views',
                      ),
                      _buildStatItem(
                        context: context,
                        icon: IconPath.likeIcon,
                        value: detailsController.natebanzay!.likeCount.toString(),
                        label: 'Likes',
                      ),
                      _buildStatItem(
                        context: context,
                        icon: IconPath.commentIcon,
                        value: detailsController.natebanzay!.commentCount.toString(),
                        label: 'Comments',
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (detailsController.natebanzay!.note?.isNotEmpty ?? false) ...[
                          Text(
                            detailsController.natebanzay!.note!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[800],
                              height: 1.5,
                              fontFamily: "Myanmar",
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Photos
                        if (detailsController.natebanzay!.photos != null) ...[
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
        GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    childAspectRatio: 1,
  ),
  itemCount: extractPhotos(detailsController.natebanzay!.photos!).length,
  itemBuilder: (context, index) {
    final photo = extractPhotos(detailsController.natebanzay!.photos!)[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        "${AppConfig.baseUrl}/storage/images/natebanzay_photos/$photo",
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image_rounded,
                size: 32,
                color: ColorApp.mainColor.withOpacity(0.3),
              ),
              const SizedBox(height: 8),
              Text(
                'Image not available',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / 
                      loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
                color: ColorApp.mainColor,
              ),
            ),
          );
        },
      ),
    );
  },
),
                        ],
                      ],
                    ),
                  ),
                ),

                // Action buttons
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: ColorApp.mainColor),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.natebanzayComments, arguments: {
                              'natebanzay_id': detailsController.natebanzay!.id,
                            });
                          },
                          icon: const Icon(Icons.comment_outlined,color: Colors.black,),
                          label: const Text('Comment',style: TextStyle(color: Colors.black),),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: ColorApp.mainColor,
                            foregroundColor: ColorApp.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => requestNatebanzayController.request(
                            detailsController.natebanzay!.id,
                            context,
                          ),
                          icon: const Icon(Icons.send_rounded,color: Colors.white,),
                          label: const Text('Request'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required String icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Image.asset(
          icon,
          color: ColorApp.mainColor,
          height: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorApp.mainColor,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }


class NateBanZayView extends GetView<HomeController> {
  final RequestNatebanzayController _requestNatebanzayController = Get.put(RequestNatebanzayController());
  final NatebanzayDetailsController _natebanzayDetailsController = Get.put(NatebanzayDetailsController());

  NateBanZayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.mainColor,
        title: Text(
          "natebanzay",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ColorApp.secondaryColor,
            fontWeight: FontWeight.w600,
            fontFamily: "Myanmar",
          ),
        ).tr(),
      ),
      drawer:  DrawerView(),
      body: RefreshIndicator(
        color: ColorApp.mainColor,
        onRefresh: () => controller.getNatebanzays(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategorySection(context),
                  _buildFilteredList(context),
                ],
              ),
            ),
            // _buildAllNatebanzays(context),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "byCategory",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Myanmar",
                ),
              ).tr(),
              TextButton(
                onPressed: () {
                  final filteredNataebanzays = controller.natebanzays
                      .where((n) => n.item.name == controller.selectedItem.name)
                      .toList();
                  Get.to(() => SeeMoreNatebanzayList(
                    title: tr("byCategory"),
                    natebanzays: filteredNataebanzays,
                    requestNatebanzayController: _requestNatebanzayController,
                    detailsController: _natebanzayDetailsController,
                  ));
                },
                child: Text(
                  "seeall",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: ColorApp.mainColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Myanmar",
                  ),
                ).tr(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  selected: item == controller.selectedItem,
                  onSelected: (_) => controller.setItem(item),
                  label: Text(item.name),
                  labelStyle: TextStyle(
                    color: item == controller.selectedItem 
                        ? Colors.white 
                        : ColorApp.dark,
                    fontFamily: "Myanmar",
                  ),
                  backgroundColor: Colors.transparent,
                  selectedColor: ColorApp.mainColor,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: item == controller.selectedItem 
                          ? ColorApp.mainColor 
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ));
            },
          ),
        ),
      ],
    );
  }





  
Widget _buildFilteredList(BuildContext context) {
  return Obx(() {
    final size = MediaQuery.of(context).size;
    final filteredNatebanzays = controller.natebanzays
        .where((natebanzay) => natebanzay.item.name == controller.selectedItem.name)
        .toList();

    if (filteredNatebanzays.isEmpty) {
      return _buildEmptyState(context);
    }

    // Calculate card width based on screen size
    final cardWidth = size.width * 0.7;
    final cardHeight = size.height * 0.5;

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        itemCount: filteredNatebanzays.length,
        itemBuilder: (context, index) {
          final natebanzay = filteredNatebanzays[index];
          return Padding(
            padding: EdgeInsets.only(right: size.width * 0.03),
            child: SizedBox(
              width: cardWidth,
              child: NatebanzayCard(
                natebanzay: natebanzay,
                requestNatebanzayController: _requestNatebanzayController,
                detailsController: _natebanzayDetailsController,
              ),
            ),
          );
        },
      ),
    );
  });
}

  
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_rounded,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No natebbanzays found in this category',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
                fontFamily: "Myanmar",
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: ColorApp.mainColor,
      elevation: 2,
      onPressed: () => _handleCreateNatebanzay(context),
      icon: Image.asset(
        IconPath.editIcon,
        height: 24,
        color: Colors.white,
      ),
      label: Text(
        "createNatebanzay",
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Myanmar",
        ),
      ).tr(),
    );
  }

  void _handleCreateNatebanzay(BuildContext context) {
    if (MySharedPref.getUserId() == null || MySharedPref.getToken() == null) {
      Get.toNamed(Routes.login);
      return;
    }

    final role = Get.find<HomeController>().profile.role;
    if (role == "user") {
      ToastHelper.showErrorToast(
        context, 
        "အလှူရှင်အကောင့်ဖြစ်မှသာ တင်လို့ရပါမည်"
      );
      Get.toNamed(Routes.donorRegister);
    } else if (role == "donor") {
      Get.toNamed(Routes.createNatebanzay);
    }
  }

  List<String> extractPhotos(String jsonString) {

  final photosWithoutEscape = jsonString.replaceAll('\\', '');

  final photosWithoutBrackets = photosWithoutEscape.substring(2, photosWithoutEscape.length - 2);

  final imageUrls = photosWithoutBrackets.split('","');

  return imageUrls;
}

}