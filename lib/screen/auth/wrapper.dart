import 'package:flutter/material.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/navbar_items/homescreen.dart';
import 'package:go_shop/services/auth_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        return snapshot.hasData ? const HomeScreen() : const LogInScreen();
      },
    );
  }
}
