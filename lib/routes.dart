import 'package:flutter/cupertino.dart';
import 'package:go_shop/screen/auth/forgot_pwd.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/auth/signup.dart';
import 'package:go_shop/screen/navbar_items/homescreen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    LogInScreen.routeName: (context) => const LogInScreen(),
    SignUpScreen.routeName: (context) => const SignUpScreen(),
    ForgotPwdScreen.routeName: (context) => const ForgotPwdScreen(),
    HomeScreen.routeName: (context) => const HomeScreen(),
    // BottomBarScreen.routeName: (context) => const BottomBarScreen(),
  };
}
