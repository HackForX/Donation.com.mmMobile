import 'package:donation_com_mm_v2/controllers/create_sadudithar_controller.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../util/app_color.dart';


class MapView extends GetView<CreateSaduditharController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(()=>controller.currentPositon==null?const Center(child: CircularProgressIndicator(),): FlutterLocationPicker(
        initPosition:  LatLong(controller.pickedLat!=0.0?controller.pickedLat:controller.currentPositon!.latitude, controller.pickedLong!=0.0?controller.pickedLong:controller.currentPositon!.longitude),
        selectLocationButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorApp.mainColor),
        ),
        selectedLocationButtonTextstyle: const TextStyle(fontSize: 18,color: ColorApp.white),
        selectLocationButtonText: 'ရွေးချယ်မည်',
        selectLocationButtonLeadingIcon: Image.asset(IconPath.pinIcon,color: ColorApp.white,height: 20,),
        initZoom: 11,
        minZoomLevel: 5,
        maxZoomLevel: 16,
        trackMyPosition: true,
        // countryFilter: 'MM',
        onError: (e) => print(e),
        onPicked: (pickedData) {
          controller.setLatitude(pickedData.latLong.latitude);
          controller.setLongitude(pickedData.latLong.longitude);
          controller.setAddress("${pickedData.address} ${pickedData.addressData['country']}");
  Get.back();

        },
        onChanged: (pickedData) {
   
        }))
    );
  }
}