import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:donation_com_mm_v2/models/natebanzay_response.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:donation_com_mm_v2/util/app_config.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShareNatebanzayView extends GetView<HomeController> {
  const ShareNatebanzayView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        controller.getNatebanzaysRequested();
      },
      child: Scaffold(
        drawer:  DrawerView(),
        appBar: AppBar(
          title: const Text("requests").tr(),
        ),
        body: MySharedPref.getUserId()==null&&MySharedPref.getToken()==null?Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("unauthorized",style: TextStyle(color: ColorApp.mainColor,fontWeight: FontWeight.w700),).tr(),
            const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
                  child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: ColorApp.mainColor,foregroundColor: ColorApp.secondaryColor),onPressed: (){}, child: const Text("login").tr()),
                )),
            ],
          )):GetBuilder<HomeController>(builder: (controller){
          return ListView.builder(
            itemCount: controller.natebanzaysRequested.length,
            itemBuilder: (BuildContext context, int index) {
              return  RequestsItemCardWidget(
      natebanzay: controller.natebanzaysRequested[index],
      controller: controller,
            );
            },
            
          );
        },)
      ),
    );
  }
}



class RequestsItemCardWidget extends StatelessWidget {
  final HomeController controller;
  final Natebanzay natebanzay;

  const RequestsItemCardWidget({
    super.key,
    required this.controller,
    required this.natebanzay,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.01,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: natebanzay.photos == null
                  ? Image.asset(
                      ImagePath.test,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "${AppConfig.baseUrl}/storage/images/natebanzay_photos/${extractPhotos(natebanzay.photos!)[0]}",
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
            ),
          ),

          // Content Section
          Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Quantity
                Text(
                  "${natebanzay.name} (${natebanzay.quantity}ခု)",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorApp.dark,
                    fontFamily: "Myanmar",
                  ),
                ),
                SizedBox(height: size.height * 0.01),

                // Request Count
                Row(
                  children: [
                    Icon(Icons.people_outline, 
                      size: 18, 
                      color: ColorApp.dark.withOpacity(0.7)
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      "${natebanzay.requestedCount}ဦး မှ တောင်းခံထားသည်",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorApp.dark.withOpacity(0.7),
                        fontFamily: "Myanmar",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),

                // Address
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, 
                      size: 18, 
                      color: ColorApp.dark.withOpacity(0.7)
                    ),
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: Text(
                        natebanzay.address,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorApp.dark.withOpacity(0.7),
                          fontFamily: "Myanmar",
                        ),
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      onTap: () => Get.toNamed(
                        Routes.viewNatebanzayRequests,
                        arguments: {"natebanzay_id": natebanzay.id}
                      ),
                      icon: Icons.visibility_outlined,
                      color: ColorApp.dark,
                      context: context,
                    ),
                    _buildActionButton(
                      onTap: () => Get.toNamed(
                        Routes.editNatebanzay,
                        arguments: {"natebanzay": natebanzay}
                      ),
                      icon: Icons.edit_outlined,
                      color: ColorApp.blue,
                      context: context,
                    ),
                    _buildActionButton(
                      onTap: () => showDeleteDialog(context, controller, natebanzay.id),
                      icon: Icons.delete_outline,
                      color: ColorApp.lipstick,
                      context: context,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    required BuildContext context,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(
            icon,
            size: 20,
            color: color,
          ),
        ),
      ),
    );
  }

 

void showDeleteDialog(BuildContext context,HomeController controller,int id){
showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Donation.com.mm'),
            content: const Text('ဖျက်ရန်သေချာပီလား?'),
            actions: [
              TextButton(
                onPressed: () =>Get.back(),
                child: const Text('မလုပ်တော့ပါ'),
              ),
              TextButton(
                onPressed: () {
                  controller.deleteNatebanzay(id, context);
                  Get.back();
                },
                child: const Text('လုပ်မည်'),
              ),
            ],
          ),
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