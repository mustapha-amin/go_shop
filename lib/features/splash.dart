import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/features/auth/view/auth_screen.dart';
import 'package:go_shop/features/auth/view/profile_setup.dart';
import 'package:go_shop/features/home/view/home_screen.dart';
import 'package:go_shop/features/onboarding/view/onboarding_screen.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';
import 'package:go_shop/shared/loader.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final hasSeenOnboarding =
          locator.get<OnboardingSettings>().hasSeenOnboarding;
      final user = locator.get<FirebaseAuth>().currentUser;
     
        if (!hasSeenOnboarding) {
          context.go(OnboardingScreen.route);
        } else if (user == null) {
          context.go(AuthScreen.route);
        } else if (user.displayName == null) {
          context.go(ProfileSetup.route);
        } else {
          context.go(HomeScreen.route);
        }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Loader()));
  }
}
