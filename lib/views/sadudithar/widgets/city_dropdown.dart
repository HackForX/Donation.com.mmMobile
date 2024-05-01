import 'package:donation_com_mm_v2/controllers/home_controller.dart';
import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_color.dart';

class CityDropdown extends StatelessWidget {
  final HomeController controller;
   const CityDropdown({super.key, required this.controller});
 

  @override
  Widget build(BuildContext context) {
    
    return   Obx((){
              final citiesController = DropdownController<String>.single(
    items: List.generate(
      controller.cities.length,
      (index) => DropdownItem(value: controller.cities[index].name),
    ),
  );
      return   SimpleDropdown<String>.list(
            controller:citiesController,
      
            builder: (_) =>Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color:  ColorApp.dark)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                     controller.selectedCity,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Myanmar",
                          color:  ColorApp.dark),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 20,
                    )
                  ],
                ),
              ),
            menuPosition: const DropdownMenuPosition(
              offset: Offset(0, 10),
            ),
            menuConstraints: const BoxConstraints(
              maxHeight: 150,
            ),
            itemBuilder: (_, item) => GestureDetector(
              onTap: () {
                citiesController.select(item.value, dismiss: true);
                controller.setCity(item.value);
              },
              child: Card(
                color: item.selected ? ColorApp.mainColor : ColorApp.bgColorGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item.value,style:  TextStyle(color: item.selected?ColorApp.white:ColorApp.dark),),
                ),
              ),
            ),
          );
    });
  }
}