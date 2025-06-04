import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/providers.dart';
import 'package:go_shop/features/auth/view/auth_screen.dart';
import 'package:go_shop/features/auth/view/profile_setup.dart';
import 'package:go_shop/features/home/view/home_screen.dart';
import 'package:go_shop/features/onboarding/view/onboarding_screen.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';
import 'package:go_shop/shared/loader.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final onboardingSettings = locator.get<OnboardingSettings>();
  final user = locator.get<FirebaseAuth>().currentUser;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:3), () {
      log("post frame");
      if (!onboardingSettings.hasSeenOnboarding) {
        context.go(OnboardingScreen.route);
        log(0.toString());
      } else if (user == null) {
        context.go(AuthScreen.route);
        log(1.toString());
      } else if (user!.displayName == null) {
        context.go(ProfileSetup.route);
        log(2.toString());
      } else {
        context.go(HomeScreen.route);
        log(3.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InkWell(
      child: Center(child: Loader())));
  }
}
