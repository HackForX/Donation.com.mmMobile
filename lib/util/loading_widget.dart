import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/loading.gif",
      height: 80,
    );
  }
}