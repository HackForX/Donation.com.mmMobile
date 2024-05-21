import 'package:donation_com_mm_v2/views/natebanzay/%20natebanzay_view.dart';
import 'package:flutter/material.dart';

import '../../controllers/natebanzay_details_controller.dart';
import '../../controllers/request_natebanzay_controller.dart';
import '../../models/natebanzay_response.dart';
import '../../util/app_color.dart';
import '../../util/app_config.dart';

class SeeMoreNatebanzayList extends StatelessWidget {
  final String title;
  final List<Natebanzay> natebanzays;
  final RequestNatebanzayController requestNatebanzayController;
  final NatebanzayDetailsController detailsController;

  const SeeMoreNatebanzayList({super.key, required this.title, required this.natebanzays, required this.requestNatebanzayController, required this.detailsController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
        itemCount:natebanzays.length ,
        itemBuilder: (BuildContext context, int index) {
          return NatebanzayCard(natebanzay: natebanzays[index], requestNatebanzayController: requestNatebanzayController, detailsController: detailsController) ;
        },
      ),
    );
  }
}




class NatebanzayCard extends StatelessWidget {
  final Natebanzay natebanzay;
  final RequestNatebanzayController requestNatebanzayController;
  final NatebanzayDetailsController detailsController;

  const NatebanzayCard({
    super.key, required this.natebanzay, required this.requestNatebanzayController,required this.detailsController
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        detailsController.getDetails(natebanzay.id);
        detailsController.view(natebanzay.id);

        showItemDetailsDialog(context,detailsController,requestNatebanzayController);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: ColorApp.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 180, 193).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          natebanzay.photos==null?const SizedBox(
                     height: 150,
               width: 200,
          ): SingleChildScrollView(scrollDirection: Axis.horizontal,child: Container(
               height: 150,
               width: 200,
               padding: const EdgeInsets.all(15),
               decoration: const BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(10))
               
               ),
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: extractPhotos(natebanzay.photos!).map((e) {
                   print("Image $e");
                   return Padding(
                     padding: const EdgeInsets.only(left:8.0),
                     child: Image.network("${AppConfig.baseUrl}/storage/images/natebanzay_photos/$e",height: 150,width: 150,fit: BoxFit.cover ,errorBuilder: (context,object,stack) {
                       print(stack);
                       print(object);
                     
                       return const Icon(Icons.error);
                     },),
                   );
                 }, ).toList(),),
             ),
             ),),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
             natebanzay.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 10),
            child: Text(
             natebanzay.address,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 4),
            child: Text(
              "${natebanzay.viewCount}views    ${natebanzay.likeCount}likes",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ),
    );
  }

List<String> extractPhotos(String jsonString) {

  final photosWithoutEscape = jsonString.replaceAll('\\', '');

  final photosWithoutBrackets = photosWithoutEscape.substring(2, photosWithoutEscape.length - 2);

  final imageUrls = photosWithoutBrackets.split('","');

  return imageUrls;
}




}
