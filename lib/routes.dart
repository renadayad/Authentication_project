import 'package:auth_app/views/screens/login_screen.dart';
import 'package:auth_app/views/screens/signup_screen.dart';
import 'package:get/route_manager.dart';

import 'logic/bindings/auth_binding.dart';


class AppRoutes {
  static const login = Routes.loginScreen;

  static final routes = [
    GetPage(
        name: Routes.loginScreen,
        page: () => Login_Screen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.signScreen,
        page: () => Signup_Screen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.forgotpasswordScreen,
        page: () => ForgotPasswordScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.settingScreen,
        page: () => SettingsScreen(),
        binding: AuthBinding()),
  ];
}

class Routes {
  static const loginScreen = '/loginScreen';
  static const signScreen = '/signScreen';
  static const forgotpasswordScreen = '/forgotpasswordScreen';
  static const settingScreen = '/settingScreen';
}