import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../util/app_color.dart';


class SaduditharMapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  const SaduditharMapView({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    print(latitude);
    return Scaffold(
      body:FlutterLocationPicker(
        initPosition:  LatLong(latitude, longitude),
        selectLocationButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorApp.mainColor),
        ),
        showSelectLocationButton: false,
        selectedLocationButtonTextstyle: const TextStyle(fontSize: 18,color: ColorApp.white),
        selectLocationButtonText: 'ရွေးချယ်မည်',
        selectLocationButtonLeadingIcon: Image.asset(IconPath.pinIcon,color: ColorApp.white,height: 20,),
        initZoom: 11,
        minZoomLevel: 5,
        maxZoomLevel: 16,
        // trackMyPosition: true,
        onError: (e) => print(e),
        onPicked: (pickedData) {
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          print(pickedData.address);
          print(pickedData.addressData['country']);
 


        },
        onChanged: (pickedData) {
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          print(pickedData.address);
          print(pickedData.addressData);
        })
    );
  }
}