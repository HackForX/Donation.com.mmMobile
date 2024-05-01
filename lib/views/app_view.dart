import 'package:donation_com_mm_v2/bindings/init_binding.dart';
import 'package:donation_com_mm_v2/routes/app_pages.dart';
import 'package:donation_com_mm_v2/util/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        //  designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme().themeLight,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            initialBinding: InitBinding(),
            builder: (context, child) {
              return WillPopScope(
                onWillPop: () async {
                  // Show exit confirmation dialog
                  bool exitConfirmed = await await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Donation.com.mm'),
                      content: const Text('ထွက်မာသေချာပီလား?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('မလုပ်တော့ပါ'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('လုပ်မည်'),
                        ),
                      ],
                    ),
                  );

                  // Return true to pop the route if exit is confirmed, false otherwise
                  return exitConfirmed;
                },
                child: EasyLoading.init()(context, child),
              );
            },
          );
        });
  }
}
