import 'package:flutter/material.dart';
import 'package:go_shop/models/category_model.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/widgets/category.dart';
import 'package:go_shop/widgets/feed_item.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<List<Category>>(context);
    var products = Provider.of<Iterable<Product>>(context).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: categories.isNotEmpty
          ? GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 20,
              childAspectRatio: 240 / 250,
              children: [
                ...categories.map(
                  (category) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text(category.name!),
                            ),
                            body: FeedsWidget(
                                products: products.where((element) =>
                                    element.category == category.name)),
                          );
                        }));
                      },
                      child: CategoryWidget(category: category),
                    ),
                  ),
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
