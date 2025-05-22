import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/features/auth/view/auth_screen.dart';
import 'package:go_shop/features/auth/view/profile_setup.dart';
import 'package:go_shop/features/bottom_nav/bottom_nav_screen.dart';
import 'package:go_shop/features/cart/view/cart_screen.dart';
import 'package:go_shop/features/favorite/view/favorites_screen.dart';
import 'package:go_shop/features/home/view/home_screen.dart';
import 'package:go_shop/features/onboarding/view/onboarding_screen.dart';
import 'package:go_shop/features/profile/view/profile.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRoutes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: HomeScreen.route,
  redirect: (context, state) {
    final hasSeenOnboarding =
        locator.get<OnboardingSettings>().hasSeenOnboarding;
    final user = locator.get<FirebaseAuth>().currentUser;
    if (!hasSeenOnboarding) {
      return OnboardingScreen.route;
    }
    if (user == null) {
      return AuthScreen.route;
    }
    if (user.displayName == null) {
      return ProfileSetup.route;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: OnboardingScreen.route,
      builder: (context, state) {
        return OnboardingScreen();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavScreen(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: HomeScreen.route,
              builder: (context, state) {
                return HomeScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: FavoritesScreen.route,
              builder: (context, state) {
                return FavoritesScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: CartScreen.route,
              builder: (context, state) {
                return CartScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ProfileScreen.route,
              builder: (context, state) {
                return ProfileScreen();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AuthScreen.route,
      builder: (context, state) {
        return AuthScreen();
      },
      routes: [
        GoRoute(
          path: ProfileSetup.route,
          builder: (context, state) {
            return ProfileSetup();
          },
        ),
      ],
    ),
  ],
);
