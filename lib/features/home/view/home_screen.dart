import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/features/home/widgets/product_card.dart';
import 'package:go_shop/features/home/widgets/skeletal_home.dart';
import 'package:go_shop/shared/simple_grid.dart';

final List<String> productCategories = [
  'All',
  'Appliances',
  'Phones and tablets',
  'Electronics',
  'Computing',
  'Clothing',
  'Other',
];

class HomeScreen extends ConsumerStatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeScreen> {
  ValueNotifier<String> selectedCategory = ValueNotifier('All');

  @override
  Widget build(BuildContext context) {
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
                    height: 50,
                    child: ValueListenableBuilder(
                      valueListenable: selectedCategory,
                      builder: (context, selected, _) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 5,
                            children: [
                              ...productCategories.map((category) {
                                return FilterChip(
                                  side: BorderSide(width: 0.5),
                                  checkmarkColor: Colors.white,
                                  selectedColor: Theme.of(context).primaryColor,
                                  label: Text(
                                    category,
                                    style: kTextStyle(
                                      14,
                                      color: category == selected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  selected: selected == category,
                                  onSelected: (_) {
                                    selectedCategory.value = category;
                                  },
                                );
                              }),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: selectedCategory,
                      builder: (context, selected, _) {
                        return SingleChildScrollView(
                          child: SimpleGrid(
                            gap: 2,
                            columns: 2,
                            children: [
                              if (selected == "All") ...{
                                ...products.map(
                                  (product) => ProductCard(product: product),
                                ),
                              } else ...{
                                ...products
                                    .where(
                                      (product) => product.category == selected,
                                    )
                                    .map(
                                      (product) =>
                                          ProductCard(product: product),
                                    ),
                              },
                            ],
                          ),
                        );
                      },
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
