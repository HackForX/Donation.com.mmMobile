import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class SaduditharMapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  const SaduditharMapView({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    print(latitude);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Preview"),
      ),
      body:FlutterMap(
      options:  MapOptions(
        initialZoom: 15,
        initialCenter: LatLng(latitude, longitude)
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.donationcommm.foc.app',
        ),
        MarkerLayer(
  markers: [
    Marker(
      point: LatLng(latitude, longitude),
      width: 70,
      height: 60,
      child:Image.asset("assets/icons/pin.png",height: 15,color: ColorApp.mainColor,)
    ),
  ],
),

      ],
    ),
    bottomNavigationBar: Container(
      
      
      margin: const EdgeInsets.only(bottom: 30,top: 30),
      height: 80,child:  InkWell(
          onTap:() {
            launchGoogleMaps(latitude,longitude);
          },
           child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      height: 80,
                      decoration: BoxDecoration(
                        color: ColorApp.mainColor,
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                      children: [
                        const SizedBox(width: 10,),
                         Text("လမ်းညွှန်ကြည့်မည်",style: TextStyle(color: ColorApp.secondaryColor,fontWeight: FontWeight.w700,fontSize: 14),),
                         const Spacer()
           ,            Image.asset("assets/icons/pin.png",height: 26,color: ColorApp.secondaryColor,),
               const SizedBox(width: 10,),
                      ],
                                ),
                    ),
         ),),
    );
  }

  
  Future<void> launchGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

}