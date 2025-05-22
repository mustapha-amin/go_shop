import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:go_shop/features/bottom_nav/providers/nav_provider.dart';

class BottomNavScreen extends ConsumerWidget {
  final StatefulNavigationShell child;
  const BottomNavScreen({required this.child, super.key});

  void _onTap(int index) {
    child.goBranch(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 20,
        title: Text(GoRouter.of(context).state.path!),
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: child.currentIndex,
        labelTextStyle: WidgetStatePropertyAll(
          kTextStyle(14, color: Theme.of(context).primaryColor),
        ),
        onDestinationSelected: (index) {
          _onTap(index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Iconsax.home_copy,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Home',
            selectedIcon: Icon(
              Iconsax.home,
              color: Theme.of(context).primaryColor,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.heart_copy,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Favorites',
            selectedIcon: Icon(
              Iconsax.heart,
              color: Theme.of(context).primaryColor,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.shopping_cart_copy,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Cart',
            selectedIcon: Icon(
              Iconsax.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.profile_circle_copy,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Profile',
            selectedIcon: Icon(
              Iconsax.profile_circle,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
