import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'username.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    if (user != null) {
      return user.displayName == null
          ? const UserName()
          : const BottomBarScreen();
    } else {
      return const LogInScreen();
    }
  }
}
