import 'package:flutter/material.dart';

import '../../../util/app_color.dart';
class SaduditharSearchBoxWidget extends StatelessWidget {
  const SaduditharSearchBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined)),
            hintText: "ရှာဖွေရန်",
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500, fontFamily: "Myanmar"),
            contentPadding: const EdgeInsets.only(left: 10, top: 20),
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 229, 225, 225)),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: ColorApp.mainColor),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            border: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 229, 225, 225)),
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }
}

