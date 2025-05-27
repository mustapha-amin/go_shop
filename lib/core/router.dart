import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/features/auth/view/auth_screen.dart';
import 'package:go_shop/features/auth/view/profile_setup.dart';
import 'package:go_shop/features/bottom_nav/bottom_nav_screen.dart';
import 'package:go_shop/features/cart/view/cart_screen.dart';
import 'package:go_shop/features/cart/view/payment_success.dart';
import 'package:go_shop/features/favorite/view/notification_screen.dart';
import 'package:go_shop/features/home/view/detail_screen.dart';
import 'package:go_shop/features/home/view/home_screen.dart';
import 'package:go_shop/features/onboarding/view/onboarding_screen.dart';
import 'package:go_shop/features/profile/view/order_items_screen.dart';
import 'package:go_shop/features/profile/view/orders.dart';
import 'package:go_shop/features/profile/view/profile.dart';
import 'package:go_shop/models/order.dart';
import 'package:go_shop/models/order_item.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRoutes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: HomeScreen.route,
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unknown route')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.go(HomeScreen.route);
          },
          child: const Text('Go to Home'),
        ),
      ),
    );
  },
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
    GoRoute(
      path: PaymentSuccessScreen.route,
      builder: (context, state) {
        return const PaymentSuccessScreen();
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
              path: NotificationScreen.route,
              builder: (context, state) {
                return NotificationScreen();
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
              routes: [
                GoRoute(
                  path: OrdersScreen.route,
                  builder: (context, state) {
                    return const OrdersScreen();
                  },
                  routes: [
                    GoRoute(
                      path: OrderItemsScreen.route,
                      builder: (context, state) {
                        final orderItems = state.extra as List<OrderItem>;
                        return OrderItemsScreen(orderItems: orderItems);
                      },
                    )
                  ]
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '${DetailScreen.route}/:id',
      builder: (context, state) {
        return DetailScreen(id: state.pathParameters['id']!);
      },
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
