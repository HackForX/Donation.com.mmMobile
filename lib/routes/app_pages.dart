import 'package:donation_com_mm_v2/bindings/create_natebanzay_binding.dart';
import 'package:donation_com_mm_v2/bindings/create_sadudithar_binding.dart';
import 'package:donation_com_mm_v2/bindings/donor_register_binding.dart';
import 'package:donation_com_mm_v2/bindings/home_binding.dart';
import 'package:donation_com_mm_v2/views/auth/login/login_view.dart';
import 'package:donation_com_mm_v2/views/auth/register/register_view.dart';
import 'package:donation_com_mm_v2/views/app_view.dart';
import 'package:donation_com_mm_v2/views/create_natebanzay/create_natebanzay_view.dart';
import 'package:donation_com_mm_v2/views/create_sadudithar/create_sadudithar_view.dart';
import 'package:donation_com_mm_v2/views/donor_register/donor_register_view.dart';
import 'package:donation_com_mm_v2/views/edit_natebanzay/edit_natebanzay_view.dart';
import 'package:donation_com_mm_v2/views/guide/guide_view.dart';
import 'package:donation_com_mm_v2/views/main/main_view.dart';
import 'package:donation_com_mm_v2/views/notification/notification_view.dart';
import 'package:donation_com_mm_v2/views/splash/splash_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => RegisterView(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.main,
      page: () => MainView(),
      binding: HomeBinding()
    ),
     GetPage(
      name: _Paths.notification,
      page: () => NotificationView(),

    ),

      GetPage(
      name: _Paths.createNatebanzay,
      page: () =>  CreateNatebanzayView(),
      binding: CreateNatebanzayBinding()
    ),
    GetPage(
      name: _Paths.createSadudithar,
      page: () =>  CreateSaduditharView(),
      binding: CreateSaduditharBinding()
    ),
    GetPage(
      name: _Paths.editNatebanzay,
      page: () =>  EditNatebanzayView(),
      binding: CreateNatebanzayBinding()
    ),
      GetPage(
      name: _Paths.donorRegister,
      page: () =>   DonorRegisterView(),
      binding: DonorRegisterBinding()
    ),
        GetPage(
      name: _Paths.guide,
      page: () =>  const GuideView(),

    ),
  ];
}
