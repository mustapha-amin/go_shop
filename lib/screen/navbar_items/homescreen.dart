import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/widgets/featured_products_swiper.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../models/product.dart';
import '../../widgets/feed_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SwiperController swiperController = SwiperController();
  TextEditingController searchbarController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Iterable<Product>>(context).toList();
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 12.h,
              width: 95.w,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                  controller: searchbarController,
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  elevation: const MaterialStatePropertyAll(2),
                  trailing: const [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    )
                  ],
                  hintText: "Search for a product",
                  hintStyle: MaterialStatePropertyAll(
                    kTextStyle(size: 12, color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h, child: const FeaturedProducts()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Our products",
                    style: kTextStyle(
                      size: 25,
                      isBold: true,
                    ),
                  ),
                ],
              ),
            ),
            FeedsWidget(products : products),
          ],
        ),
      ),
    );
  }
}
