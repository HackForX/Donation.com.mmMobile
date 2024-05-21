import 'package:flutter/material.dart';

import '../../../models/sadudithar_response.dart';
import '../../../util/app_color.dart';
import '../../../util/app_config.dart';
import '../../../util/assets_path.dart';
import 'distance_widget.dart';

class SeeMoreSaduditharList extends StatelessWidget {
  final String title;
  final List<Sadudithar> sadudithars;
  const SeeMoreSaduditharList({super.key, required this.title, required this.sadudithars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      
      ),
      body: ListView.builder(
        itemCount: sadudithars.length,
        itemBuilder: (BuildContext context, int index) {
          Sadudithar sadudithar=sadudithars[index];
          return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color:  ColorApp.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 180, 193).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Container(
                // margin: const EdgeInsets.all(15),
                height: 150,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      10,
                    ),
                    topRight: Radius.circular(
                      10,
                    ),
                  ),
                  image: DecorationImage(
                      image: NetworkImage("${AppConfig.baseUrl}/storage/${sadudithar.image}"),
                      fit: BoxFit.cover),
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
             sadudithar.eventDate,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontFamily: "English", fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
              sadudithar.title ,
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
      ) ;
        },
      ),
    );
  }
}