import 'package:donation_com_mm_v2/controllers/create_sadudithar_controller.dart';
import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/city_response.dart';
import '../../../util/app_color.dart';

class CityDropDown extends StatelessWidget {

    const CityDropDown({super.key,required this.controller});
 
final CreateSaduditharController controller;
  @override
  Widget build(BuildContext context) {

 

    
    return   Obx((){
              final citiesController = DropdownController<SaduditharCity>.single(
    items: List.generate(
      controller.cities.length,
      (index) => DropdownItem(value: controller.cities[index]),
    ),
  );
      return   SimpleDropdown<SaduditharCity>.list(
            controller:citiesController,
      menuDecoration: BoxDecoration(
        color: ColorApp.bgColorGrey,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
           boxShadow: [
                    BoxShadow(
                        color: ColorApp.mainColor.withOpacity(0.3),
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                        spreadRadius: 0),
                  ],
      ),
            builder: (_) =>Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: ColorApp.bgColorGrey,
                 
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color:  ColorApp.bgColorGrey)),
                child: Row(

                  children: [
                    Text(
                    controller.selectedCity.name,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Myanmar",
                          fontSize: 16,
                          color:  ColorApp.dark),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 30,
                    )
                  ],
                ),
              ),
            menuPosition: const DropdownMenuPosition(
              offset: Offset(30, -100),
            ),
            menuConstraints: const BoxConstraints(
              maxHeight: 200,
            ),
            itemBuilder: (_, item) => GestureDetector(
              onTap: () {
                citiesController.select(item.value, dismiss: true);
                controller.setCity(item.value);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
             margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              
                decoration: BoxDecoration
              (
                  color: ColorApp.mainColor.withOpacity(0.8),
             
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item.value.name,style:  TextStyle(color: item.selected?ColorApp.secondaryColor:ColorApp.white),),
                ),
              ),
            ),
          );
    });
  }
}