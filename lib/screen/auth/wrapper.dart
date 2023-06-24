import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapsot) {
        if (snapsot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
        if (snapsot.hasData) {
          return const BottomBarScreen();
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}
