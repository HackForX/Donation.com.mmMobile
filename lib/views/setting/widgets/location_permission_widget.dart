import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../util/app_color.dart';

class LocationToggleScreen extends StatefulWidget {
  const LocationToggleScreen({super.key});

  @override
  _LocationToggleScreenState createState() => _LocationToggleScreenState();
}

class _LocationToggleScreenState extends State<LocationToggleScreen> with WidgetsBindingObserver {
  bool _isLocationEnabled = false;
  bool _isCheckingPermission = false;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkLocationPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkLocationPermission();
    }
  }

  Future<void> _checkLocationPermission() async {
    setState(() {
      _isCheckingPermission = true;
    });

    PermissionStatus status = await Permission.location.status;
    setState(() {
      _isLocationEnabled = status.isGranted;
      _isCheckingPermission = false;
    });
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        _isLocationEnabled = true;
      });
    } else if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
    } else {
      setState(() {
        _isLocationEnabled = false;
      });
    }
  }

  Future<void> _openAppSettings() async {
    if (await openAppSettings()) {
      print('App Settings opened');
    } else {
      print('Failed to open App Settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isCheckingPermission
          ? const CircularProgressIndicator()
          : SwitchListTile(
            activeColor: ColorApp.white,
            activeTrackColor: ColorApp.mainColor,
            inactiveTrackColor: ColorApp.dark,
              title: const Text('location').tr(),
              value: _isLocationEnabled,
              onChanged: (bool value) async {
                if (value) {
                  await _requestLocationPermission();
                } else {
                  setState(() {
                    _showDisablePermissionInfo(context);
                  });
                }
              },
            ),
    );
  }

  void _showDisablePermissionInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Disable Location Permission'),
          content: const Text(
              'To disable location permission, please go to the app settings and turn off location permission manually.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () async {
                await _openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
              'Location permission is permanently denied. Please go to the app settings and enable location permission manually.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
