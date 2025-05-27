import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/auth/view/auth_screen.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  static const route = '/';
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 15.h),
          Stack(
            children: [
              SvgPicture.asset('assets/images/onboarding.svg', width: 80.w),
              Positioned(
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/go_shop.svg',
                  width: 50.w,
                ),
              ),
            ],
          ),
          Column(
            spacing: 8,
            children: [
              Text(
                "Bringing the Market to Your Fingertips.",
                style: kTextStyle(
                  24,
                  fontweight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              ShadButton(
                width: 100.w,
                height: 60,
                onPressed: () async {
                  await locator.get<OnboardingSettings>().completeOnboarding();
                  if (context.mounted) {
                    context.go(AuthScreen.route);
                  }
                },
                child: Text(
                  "Get started",
                  style: kTextStyle(16, color: Colors.white),
                ),
              ).padY(5),
            ],
          ),
        ],
      ).padX(14).padY(10),
    );
  }
}
