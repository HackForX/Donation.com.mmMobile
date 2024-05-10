import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/sadudithar_response.dart';
import '../../../util/app_color.dart';
import '../../../util/app_config.dart';
import '../../sadudithar_details/sadudithar_details_view.dart';


class CitySaduditarCard extends StatelessWidget {
  final Sadudithar sadudithar;
  const CitySaduditarCard({
    super.key, required this.sadudithar,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.saduditharDetails,arguments: {
        'sadudithar':sadudithar
      }),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: ColorApp.white,
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
          Stack(
            children: [
              Container(
                height: 150,
                width: 300,
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
              Positioned(
                right: 5,
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: ColorApp.mainColor,
                  ),
                  child: Text(
                 sadudithar.city.name,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontFamily: "English",
                        fontWeight: FontWeight.w600,
                        color:  ColorApp.white),
                  ),
                ),
              )
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
            sadudithar.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 10),
            child: Text(
              sadudithar.township.name,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 4, bottom: 8),
            child: Text(
              "${sadudithar.estimatedQuantity}ဦး",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontFamily: "Myanmar", fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ),
    );
  }
}
