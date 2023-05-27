import 'package:flutter/material.dart';
import 'package:go_shop/models/category_model.dart';
import 'package:go_shop/widgets/category.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  static String basePath = 'assets/images/categories';
  List<Category> categories = [
    Category(name: "Shoes", imgPath: '$basePath/shoes.png'),
    Category(name: "Clothes", imgPath: '$basePath/clothes.png'),
    Category(name: "Laptops", imgPath: '$basePath/computers.png'),
    Category(name: "Assesories", imgPath: '$basePath/assesories.png'),
    Category(name: "Smartphones", imgPath: '$basePath/smartphones.png'),
    Category(name: "Watches", imgPath: '$basePath/watches.png'),
    Category(name: "Gaming", imgPath: '$basePath/gaming.png'),
    Category(name: "Electronics", imgPath: '$basePath/electronics.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 20,
        childAspectRatio: 240 / 250,
        children: [
          ...categories.map((category) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CategoryWidget(category: category),
              )),
        ],
      ),
    );
  }
}
