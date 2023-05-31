import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';
import 'package:go_shop/screen/navbar_items/homescreen.dart';
import 'package:go_shop/services/auth_service.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:go_shop/widgets/error_dialog.dart';

import 'username.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return authService.user!.displayName == null
              ? const UserInfo()
              : const BottomBarScreen();
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("An error occured"),
          );
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}
