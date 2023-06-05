import 'package:flutter/material.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';
import 'package:go_shop/providers/auth_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const BottomBarScreen();
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
