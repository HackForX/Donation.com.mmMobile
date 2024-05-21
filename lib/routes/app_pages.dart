import 'package:donation_com_mm_v2/bindings/chat_binding.dart';
import 'package:donation_com_mm_v2/bindings/contact_binding.dart';
import 'package:donation_com_mm_v2/bindings/create_natebanzay_binding.dart';
import 'package:donation_com_mm_v2/bindings/create_sadudithar_binding.dart';
import 'package:donation_com_mm_v2/bindings/donor_register_binding.dart';
import 'package:donation_com_mm_v2/bindings/edit_natebanzay_binding.dart';
import 'package:donation_com_mm_v2/bindings/history_binding.dart';
import 'package:donation_com_mm_v2/bindings/home_binding.dart';
import 'package:donation_com_mm_v2/bindings/natebanzay_details_binding.dart';
import 'package:donation_com_mm_v2/bindings/natebanzay_request_binding.dart';
import 'package:donation_com_mm_v2/bindings/notification_binding.dart';
import 'package:donation_com_mm_v2/bindings/sadudithar_details_binding.dart';
import 'package:donation_com_mm_v2/views/auth/login/login_view.dart';
import 'package:donation_com_mm_v2/views/auth/register/register_view.dart';
import 'package:donation_com_mm_v2/views/app_view.dart';
import 'package:donation_com_mm_v2/views/chat/chat_view.dart';
import 'package:donation_com_mm_v2/views/contact/contact_view.dart';
import 'package:donation_com_mm_v2/views/create_natebanzay/create_natebanzay_view.dart';
import 'package:donation_com_mm_v2/views/create_sadudithar/create_sadudithar_view.dart';
import 'package:donation_com_mm_v2/views/donor_register/donor_register_view.dart';
import 'package:donation_com_mm_v2/views/edit_natebanzay/edit_natebanzay_view.dart';
import 'package:donation_com_mm_v2/views/guide/guide_view.dart';
import 'package:donation_com_mm_v2/views/history/history_view.dart';
import 'package:donation_com_mm_v2/views/main/main_view.dart';
import 'package:donation_com_mm_v2/views/natebanzay_comments/natebanzay_comments_view.dart';
import 'package:donation_com_mm_v2/views/natebanzay_requests/natebanzay_requests_view.dart';
import 'package:donation_com_mm_v2/views/notification/notification_view.dart';
import 'package:donation_com_mm_v2/views/sadudithar_comments/sadudithar_comments_view.dart';
import 'package:donation_com_mm_v2/views/sadudithar_details/sadudithar_details_view.dart';
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
      page: () => const NotificationView(),
      binding: NotificationBinding()

    ),
     GetPage(
      name: _Paths.chat,
      page: () =>  ChatView(),
      binding: ChatBinding()

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
      binding: EditNatebanzayBinding()
    ),
      GetPage(
      name: _Paths.donorRegister,
      page: () =>   DonorRegisterView(),
      binding: DonorRegisterBinding()
    ),
     GetPage(
      name: _Paths.viewNatebanzayRequests,
      page: () =>   NatebanzayRequestsView(),
      binding: NatebanzayRequestBinding()
    ),
      GetPage(
      name: _Paths.saduditharDetails,
      page: () =>   SaduditharDetailsView(),
      binding: SaduditharDetailsBinding()
    ),
    GetPage(
      name: _Paths.saduditharComments,
      page: () =>    SaduditharCommentsView(),
      binding: SaduditharDetailsBinding()
    ),
      GetPage(
      name: _Paths.natebanzayComments,
      page: () =>    NatebanzayCommentsView(),
      binding: NatebanzayDetailsBinding()
    ),

        GetPage(
      name: _Paths.guide,
      page: () =>  const GuideView(),

    ),
    GetPage(
      name: _Paths.notification,
      page: () =>  const NotificationView(),
      binding: NotificationBinding()
    ),
      GetPage(
      name: _Paths.history,
      page: () =>  const HistoryView(),
      binding: HistoryBinding()
    ),
       GetPage(
      name: _Paths.contact,
      page: () =>  const ContactView(),
      binding: ContactBinding()
    ),
  ];
}
