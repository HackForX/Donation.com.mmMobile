import 'package:donation_com_mm_v2/controllers/create_sadudithar_controller.dart';
import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:flutter/material.dart';

import '../../../util/app_color.dart';

class CategoryDropDown extends StatelessWidget {

    const CategoryDropDown({super.key,required this.controller});
 
final CreateSaduditharController controller;
  @override
  Widget build(BuildContext context) {

 
          final itemsController = DropdownController<String>.single(
    items: [
       const DropdownItem(value:"food"),
       const DropdownItem(value:"item"),

    ]
  );
    
  //   return   Obx((){
    
      
  //   });
  return    SimpleDropdown<String>.list(
            controller:itemsController,
      
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
                    controller.selectedCategory,
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
              maxHeight: 300,
            ),
            itemBuilder: (_, item) => GestureDetector(
              onTap: () {
                itemsController.select(item.value, dismiss: true);

                controller.setCategory(item.value);
              },
              child: Card(
                elevation: 0,
                color: ColorApp.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                   child: Text(item.value,style:  TextStyle(color: item.selected?ColorApp.secondaryColor:ColorApp.white),),
                ),
              ),
            ),
          );
  }
}