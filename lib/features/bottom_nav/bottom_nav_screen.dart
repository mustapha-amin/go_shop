import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/cart/controller/payment_controller.dart';
import 'package:go_shop/features/cart/view/cart_screen.dart';
import 'package:go_shop/models/order.dart';
import 'package:go_shop/models/payment_status.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/shared/flushbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:uuid/uuid.dart';

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
        toolbarHeight: 50,
        title:
            child.currentIndex == 0
                ? Text(
                  "Go Shop",
                  style: kTextStyle(28, fontweight: FontWeight.bold),
                )
                : null,
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
              Iconsax.search_normal_copy,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Search',
            selectedIcon: Icon(
              Iconsax.search_normal,
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
      floatingActionButton:
          GoRouter.of(context).state.path != '/cart'
              ? null
              : FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor:
                    ref.watch(selectedItemsProvider).isEmpty
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                label: Row(
                  spacing: 5,
                  children: [
                    Icon(Iconsax.shopping_bag, color: Colors.white, size: 20),
                    Text(
                      "Checkout ${NumberFormat.simpleCurrency(name: 'N', decimalDigits: 0).format(ref.watch(selectedProductsPriceProvider))}",
                    ),
                  ],
                ),

                onPressed:
                    ref.watch(selectedItemsProvider).isEmpty
                        ? null
                        : () async {
                          ref
                              .read(paymentNotifierProvider.notifier)
                              .makePayment(
                                context,
                                ref,
                                Order(
                                  orderId: Uuid().v4(),
                                  userId:
                                      locator
                                          .get<FirebaseAuth>()
                                          .currentUser!
                                          .uid,
                                  items: ref.read(orderitemsProvider),
                                  createdAt: Timestamp.now(),
                                  totalAmount: ref.read(
                                    selectedProductsPriceProvider,
                                  ),
                                ),
                              );
                        },
              ),
    );
  }
}
