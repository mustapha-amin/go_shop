import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/features/home/widgets/product_card.dart';
import 'package:go_shop/features/home/widgets/skeletal_home.dart';
import 'package:go_shop/models/product.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

final List<String> productCategories = [
  'Appliances',
  'Phones and tablets',
  'Electronics',
  'Computing',
  'Clothing',
  'Other',
];

class HomeScreen extends ConsumerWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(productNotifierProvider)
        .when(
          data: (products) {
            log(products.length.toString());
            return RefreshIndicator(
              onRefresh: () {
                return ref
                    .read(productNotifierProvider.notifier)
                    .refreshProducts();
              },
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(
                    height: 45,
                    child: SearchBar(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(3)),
                      elevation: WidgetStatePropertyAll(0),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xfffff7f7f7),
                      ),
                      hintText: "Search products",
                      hintStyle: WidgetStatePropertyAll(
                        kTextStyle(16, color: Colors.grey),
                      ),
                      leading: Icon(
                        Iconsax.search_normal_1_copy,
                        size: 20,
                      ).padX(7),
                    ),
                  ),
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      children: [
                        ...List.generate(20, (_) {
                          return ProductCard(product: products[0]);
                        }),
                      ],
                    ),
                  ),
                ],
              ).padX(14),
            );
          },
          error: (e, _) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(e.toString(), style: const TextStyle(color: Colors.red)),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(productNotifierProvider.notifier)
                          .refreshProducts();
                    },
                    child: Text("Refesh"),
                  ),
                ],
              ),
            );
          },
          loading: () {
            return SkeletalHome();
          },
        );
  }
}
