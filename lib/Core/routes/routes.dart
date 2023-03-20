import 'package:auth_app/Features/Auth/view/screens/login_screen.dart';
import 'package:auth_app/Features/Profile/view/screens/profile.dart';
import 'package:auth_app/Features/Auth/view/screens/signup_screen.dart';
import 'package:get/route_manager.dart';
import '../../Features/Auth/logic/bindings/auth_binding.dart';
import '../../Features/Auth/view/screens/forget_password.dart';
import '../../Features/Profile/logic/bindings/profile_binding.dart';
import '../../Features/Profile/view/screens/change_password_page.dart';

class AppRoutes {
  //static const login = Routes.loginScreen;

  static final routes = [
    GetPage(
        name: Routes.loginScreen,
        page: () => Login_Screen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.signScreen,
        page: () => SignUpScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.forgotpasswordScreen,
        page: () => ForgotPasswordScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.profileScreen,
        page: () => ProfileScreen(),
        binding: AuthBinding()),
    // GetPage(
    //     name: Routes.oTPScreen,
    //     page: () => OTPScreen(),
    //     binding: AuthBinding()),
    GetPage(
        name: Routes.changePassword,
        page: () => ChangePsswordPage(),
        binding: ProfileBinding()),
  ];
}

class Routes {
  static const loginScreen = '/loginScreen';
  static const signScreen = '/signScreen';
  static const forgotpasswordScreen = '/forgotpasswordScreen';
  static const profileScreen = '/profileScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const settingsScreen = '/settingsScreen';
  static const changePassword = '/ChangePsswordPage';
  //static const oTPScreen = '/OTPScreen';
}
