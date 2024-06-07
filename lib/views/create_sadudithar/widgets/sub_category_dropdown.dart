import 'package:donation_com_mm_v2/controllers/create_sadudithar_controller.dart';
import 'package:donation_com_mm_v2/models/category_response.dart';
import 'package:dropdown_overlay/dropdown_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_color.dart';

class SubCategoryDropDown extends StatelessWidget {

    const SubCategoryDropDown({super.key,required this.controller});
 
final CreateSaduditharController controller;
  @override
  Widget build(BuildContext context) {

 

    
    return   Obx((){
       final subCategoriesController = DropdownController<SaduditharCategory>.single(
        items: controller.categories
            .where((category) => category.type == controller.selectedCategory)
            .toList()
            .map(
              (category) => DropdownItem(
                value: category,
              ),
            )
            .toList(),
      );

      return   SimpleDropdown<SaduditharCategory>.list(
            controller:subCategoriesController,
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
                    controller.selectedSubCategory.name,
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
                subCategoriesController.select(item.value, dismiss: true);
                controller.setSubCategory(item.value);
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