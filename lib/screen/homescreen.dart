import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String basePath = 'assets/images/offers';
  List<Category> categories = [
    Category(name: "Shoes", imgPath: '$basePath/shoes.png'),
    Category(name: "Clothes", imgPath: '$basePath/shirt.png'),
    Category(name: "Laptops", imgPath: '$basePath/laptop.png'),
    Category(name: "Assesories", imgPath: '$basePath/airpod.png'),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height / 3,
        child: Swiper(
          itemBuilder: (context, index) {
            return Image.asset(
              categories[index].imgPath!,
              fit: BoxFit.contain,
            );
          },
          itemCount: categories.length,
          pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              color: Colors.white,
              activeColor: Colors.redAccent,
            ),
          ),
          control: SwiperControl(),
        ),
      ),
    );
  }
}
