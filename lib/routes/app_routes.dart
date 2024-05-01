part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const main = _Paths.main;
  static const sadudithar = _Paths.sadudithar;
  static const natebanzay = _Paths.natebanzay;

  static const notification = _Paths.notification;
  static const contactInfo = _Paths.contactInfo;
  static const createNatebanzay = _Paths.createNatebanzay;
  static const createSadudithar = _Paths.createSadudithar;

  static const editNatebanzay = _Paths.editNatebanzay;

  static const donorRegister = _Paths.donorRegister;
  static const guide = _Paths.guide;



}

abstract class _Paths {
  _Paths._();
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const sadudithar = '/sadudithar';
  static const natebanzay = '/natebanzay';
  static const notification = '/notification';
  static const contactInfo = '/contactInfo';
  static const createNatebanzay = '/createNatebanzay';
  static const createSadudithar = '/createSadudithar';

  static const editNatebanzay = '/editNatebanzay';

  static const donorRegister = '/donorRegister';
  static const guide = '/guide';



}
