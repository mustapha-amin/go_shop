import 'package:flutter/cupertino.dart';
import 'package:go_shop/screen/auth/forgot_pwd.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/auth/signup.dart';
import 'screen/inner_screens/on_sale.dart';
import 'screen/inner_screens/wishlist.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    DiscountScreen.routeName: (context) => const DiscountScreen(),
    WishlistScreen.routeName: (context) => const WishlistScreen(),
    LogInScreen.routeName: (context) => const LogInScreen(),
    SignUpScreen.routeName: (context) => const SignUpScreen(),
    ForgotPwdScreen.routeName: (context) => const ForgotPwdScreen(),
    // BottomBarScreen.routeName: (context) => const BottomBarScreen(),
  };
}
