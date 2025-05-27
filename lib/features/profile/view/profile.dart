import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/providers.dart';
import 'package:go_shop/features/profile/view/orders.dart';
import 'package:go_shop/features/profile/widget/profile_listtile.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends ConsumerWidget {
  static const route = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListView(
      children: [
        ref
            .watch(currentUserNotifierProvider)
            .when(
              data: (user) {
                final initials =
                    user.name!.split(' ').map((e) => e[0].toUpperCase()).join();
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 14),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 8.w,
                        backgroundColor: theme.primaryColor,
                        child: Text(
                          initials,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        user.name!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email!,
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                      Divider(height: 2.h, thickness: 1),
                      // Account Information
                      ProfileListTile(
                        title: 'Profile Details',
                        subtitle: 'Name, email, phone',
                        icon: Iconsax.user,
                        onTap: () => context.push('/profile/edit'),
                      ),
                      ProfileListTile(
                        title: 'My Addresses',
                        subtitle: 'Manage shipping addresses',
                        icon: Iconsax.location,
                        onTap: () => context.push('/profile/addresses'),
                      ),
                      Divider(height: 2.h, thickness: 1),
                      // Order Management
                      ProfileListTile(
                        title: 'My Orders',
                        subtitle: 'View order history',
                        icon: Iconsax.shopping_bag,
                        onTap:
                            () => context.push(
                              ProfileScreen.route + OrdersScreen.route,
                            ),
                      ),
                      ProfileListTile(
                        title: 'Returns & Refunds',
                        subtitle: 'Manage returns',
                        icon: Iconsax.refresh,
                        onTap: () => context.push('/profile/returns'),
                      ),
                      Divider(height: 2.h, thickness: 1),
                      // Preferences
                      ProfileListTile(
                        title: 'Wishlist',
                        subtitle: 'Your saved items',
                        icon: Iconsax.heart,
                        onTap: () => context.push('/profile/wishlist'),
                      ),
                      ProfileListTile(
                        title: 'Payment Methods',
                        subtitle: 'Manage cards & payments',
                        icon: Iconsax.card,
                        onTap: () => context.push('/profile/payments'),
                      ),
                      Divider(height: 2.h, thickness: 1),
                      // Settings and Support
                      ProfileListTile(
                        title: 'Notifications',
                        subtitle: 'Manage alerts',
                        icon: Iconsax.notification,
                        onTap: () => context.push('/profile/notifications'),
                      ),
                      ProfileListTile(
                        title: 'Help & Support',
                        subtitle: 'FAQs, contact us',
                        icon: Iconsax.support,
                        onTap: () => context.push('/profile/support'),
                      ),
                      ProfileListTile(
                        title: 'Settings',
                        subtitle: 'Language, theme',
                        icon: Iconsax.setting,
                        onTap: () => context.push('/profile/settings'),
                      ),
                      Divider(height: 2.h, thickness: 1),
                      // Account Actions
                      ProfileListTile(
                        title: 'Logout',
                        icon: Iconsax.logout,
                        trailing: Icon(
                          Iconsax.arrow_right_3_copy,
                          size: 16.sp,
                          color: Colors.red.withValues(alpha: 0.5),
                        ),
                        onTap: () {
                          // ref.read(authProvider.notifier).logout();
                          context.go('/login');
                        },
                      ),
                    ],
                  ),
                );
              },
              error: (e, _) {
                return Center(
                  child: Text(
                    'Error loading profile: $e',
                    style: TextStyle(fontSize: 14.sp, color: Colors.red),
                  ),
                );
              },
              loading: () {
                return Skeletonizer(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 2.h,
                      horizontal: 4.w,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 8.w,
                          backgroundColor: theme.primaryColor,
                          child: Text(
                            'JD', // Replace with user initials or image
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'John Doe', // Replace with user name
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'john.doe@example.com', // Replace with user email
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                        Divider(height: 2.h, thickness: 1),
                        // Account Information
                        ...List.generate(8, (_) {
                          return ProfileListTile(
                            title: 'Loading...',
                            subtitle: 'Please wait',
                            icon: Iconsax.icon,
                            onTap: () {},
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
      ],
    );
  }
}
