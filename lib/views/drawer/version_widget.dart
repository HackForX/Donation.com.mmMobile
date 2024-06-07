import 'package:donation_com_mm_v2/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionWidget extends StatefulWidget {
  const VersionWidget({super.key});

  @override
  State<VersionWidget> createState() => _VersionWidgetState();
}

class _VersionWidgetState extends State<VersionWidget> {
    String _version = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'Version: ${packageInfo.version}';
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Text(_version,style: TextStyle(color: ColorApp.secondaryColor,fontSize: 14,fontWeight: FontWeight.bold),);
  }
}