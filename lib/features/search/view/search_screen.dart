import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/bottom_nav/providers/product_notifier.dart';
import 'package:go_shop/features/home/widgets/product_card.dart';
import 'package:go_shop/models/product.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const route = '/search';
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<Product> results = [];
  bool isSearching = false;
  SearchController searchController = SearchController();

  void resetSearchConfigs() {
    setState(() {
      results = [];
      isSearching = false;
    });
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        SizedBox(
          height: 45,
          child: Expanded(
            child: SearchBar(
              controller: searchController,
              padding: WidgetStatePropertyAll(EdgeInsets.all(3)),
              elevation: WidgetStatePropertyAll(0),
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
                resetSearchConfigs();
              },
              onChanged: (value) {
                setState(() {
                  results =
                      value.isEmpty
                          ? []
                          : ref
                              .watch(productNotifierProvider)
                              .value!
                              .where(
                                (product) => product.name
                                    .toLowerCase()
                                    .startsWith(value.toLowerCase()),
                              )
                              .toList();
                });
              },
              backgroundColor: WidgetStatePropertyAll(Color(0xfffff7f7f7)),
              hintText: "Search products",
              hintStyle: WidgetStatePropertyAll(
                kTextStyle(16, color: Colors.grey),
              ),
              leading: Icon(Iconsax.search_normal_1_copy, size: 20).padX(7),
            ),
          ),
        ),
        Expanded(
          child:
              results.isEmpty
                  ? Icon(
                    Iconsax.search_status_copy,
                    size: 100,
                    color: Colors.grey,
                  )
                  : GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: [
                      ...results.map((prod) => ProductCard(product: prod)),
                    ],
                  ),
        ),
      ],
    ).padX(14);
  }
}
