import 'package:donation_com_mm_v2/controllers/sadudithar_details_controller.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/views/sadudithar_details/widgets/sadudithar_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';

import '../sadudithar/widgets/sadidithar_map_view.dart';



class SaduditharDetailsView extends StatefulWidget {
  const SaduditharDetailsView({super.key});

  @override
  State<SaduditharDetailsView> createState() => _SaduditharDetailsViewState();
}

class _SaduditharDetailsViewState extends State<SaduditharDetailsView> {
  final sadudithar = Get.arguments['sadudithar'];
  final controller = Get.find<SaduditharDetailsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    controller.getDetails(sadudithar.id);
    controller.getComments(sadudithar.id);
    controller.view(sadudithar.id, context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.sadudithar == null) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorApp.mainColor,
              strokeWidth: 2,
            ),
          );
        }
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(),
                  _buildDonationDetails(),
                  _buildEngagementSection(),
                  if (controller.sadudithar!.description?.isNotEmpty ?? false)
                    _buildDescriptionSection(),
                  if (controller.sadudithar!.latitude != null)
                    _buildMapButton(),
                  _buildStatsSection(),
                  _buildCommentsSection(),
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton: _buildCommentFAB(),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SaduditharImageWidget(
          sadudithar: controller.sadudithar!,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Visibility(
                  visible: controller.sadudithar?.isShow==0?false:true,
                  child: Text(
                    "${controller.sadudithar!.user.name} မှ လှူဒါန်းသည်",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: "Myanmar",
                          color: ColorApp.mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              _buildLikeButton(),
            ],
          ),
        ),
      ],
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorApp.mainColor,
      title:  Text(
        "အသေးစိတ်",
        style: TextStyle(color: ColorApp.secondaryColor, fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        icon:  Icon(Icons.arrow_back_ios, color: ColorApp.secondaryColor),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildLikeButton() {
    return IconButton(
      icon: Icon(
        controller.sadudithar!.like != null 
            ? Icons.favorite 
            : Icons.favorite_outline,
        color: ColorApp.mainColor,
      ),
      onPressed: () => controller.like(sadudithar.id, context),
    );
  }

  Widget _buildDonationDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${DateFormat('MMMM d, yyyy').format(DateTime.parse(sadudithar.eventDate))} ${controller.sadudithar!.estimatedTime}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorApp.dark.withOpacity(0.7),
                  fontFamily: "Myanmar",
                ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.sadudithar!.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.w700,
                  color: ColorApp.mainColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildEngagementItem(
            IconPath.viewIcon,
            controller.sadudithar!.viewCount.toString(),
          ),
          const SizedBox(width: 16),
          _buildEngagementItem(
            IconPath.commentIcon,
            controller.comments.length.toString(),
          ),
          const SizedBox(width: 16),
          _buildEngagementItem(
            IconPath.heartIcon,
            controller.sadudithar!.likeCount.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementItem(String icon, String count) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 18,
          color: ColorApp.dark.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Text(
          count,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorApp.dark.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        controller.sadudithar!.description ?? "",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: "Myanmar",
              color: ColorApp.dark.withOpacity(0.8),
              height: 1.5,
            ),
      ),
    );
  }

  Widget _buildMapButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        onPressed: _handleMapNavigation,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorApp.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: Icon(Icons.map, color: ColorApp.secondaryColor),
        label: Text(
          "မြေပုံကြည့်မည်",
          style: TextStyle(
            color: ColorApp.secondaryColor,
            fontWeight: FontWeight.w600,
            fontFamily: "Myanmar",
          ),
        ),
      ),
    );
  }

  Future<void> _handleMapNavigation() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      Get.to(() => SaduditharMapView(
            latitude: controller.sadudithar!.latitude,
            longitude: controller.sadudithar!.longitude,
          ));
    } else {
      _showLocationDialog();
    }
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStatItem("လှူဖွယ်", controller.sadudithar!.category.name),
          _buildStatItem("အရေအတွက်", controller.sadudithar!.estimatedQuantity.toString()),
          _buildStatItem("နေရာ", controller.sadudithar!.township.name),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: ColorApp.mainColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ColorApp.mainColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: ColorApp.mainColor.withOpacity(0.8),
                  fontFamily: "Myanmar",
                  fontSize: 12,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorApp.dark,
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "မှတ်ချက်များ",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: "Myanmar",
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        ListView.builder(
          itemCount: controller.comments.length < 5 ? controller.comments.length : 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) => _buildCommentItem(index),
        ),
      ],
    );
  }

  Widget _buildCommentItem(int index) {
    final comment = controller.comments[index];
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: ColorApp.bgColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(ImagePath.profile),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.user.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorApp.dark,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMM d, y').format(
                          DateTime.parse(comment.createdAt),
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorApp.dark.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.comment,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorApp.dark,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Donation.com.mm'),
        content: const Text('openLocation').tr(),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('no').tr(),
          ),
          TextButton(
            onPressed: () {
              controller.openLocationSetting();
              Get.back();
            },
            child: const Text('yes').tr(),
          ),
        ],
      ),
    );
  }
  // ... Add other helper methods for each section

  Widget _buildCommentFAB() {
    return FloatingActionButton(
      backgroundColor: ColorApp.mainColor,
      elevation: 2,
      child: Icon(Icons.comment_outlined, color: ColorApp.secondaryColor),
      onPressed: () => Get.toNamed(
        Routes.saduditharComments,
        arguments: {'sadudithar_id': sadudithar.id},
      ),
    );
  }
}

  Future<void> launchGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  launchMap(String url) async {
    // const url = 'https://maps.app.goo.gl/xgWdBiynUnzWAJZK9';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      EasyLoading.showError("Can't launch map ");
    }
  }

  String extractSrcValueFromIframe(String iframeHtml) {
    final document = parse(iframeHtml);
    final iframeElement = document.querySelector('iframe');

    // Check if iframe element exists and has a src attribute
    if (iframeElement != null && iframeElement.attributes.containsKey('src')) {
      return iframeElement.attributes['src']!;
    }

    return 'Src value not found';
  }

