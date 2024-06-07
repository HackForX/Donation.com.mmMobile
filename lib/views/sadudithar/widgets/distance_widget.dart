import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../util/app_color.dart';

class DistanceWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  const DistanceWidget({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: calculateDistance(latitude,longitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, display a loading indicator or placeholder
          return  Text(
           "--- km",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontFamily: "Myanmar",
                                  color:  ColorApp.white,
                                  fontWeight: FontWeight.w600),
                        );
        } else if (snapshot.hasError) {
          // If there's an error fetching the user, display an error message
          return const Text('--');
        } else {
          print("DD ${snapshot.data}");
        return Text(
           "${   snapshot.data!.toStringAsFixed(3)} km",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontFamily: "Myanmar",
                                  color:  ColorApp.white,
                                  fontWeight: FontWeight.w600),
                        );

        }
    
      },
    );
  }
  
}


  Future<double> calculateDistance(double latitude, double longitude) async {


      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double startLatitude = position.latitude;
      double startLongitude = position.longitude;



      // Calculate the distance
      double distanceInMeters = Geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        latitude,
        longitude,
      );
      print("Distance $distanceInMeters");
      return distanceInMeters/1000;
  }