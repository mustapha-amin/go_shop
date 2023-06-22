import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/widgets/featured_products_swiper.dart';
import 'package:sizer/sizer.dart';
import 'package:card_swiper/card_swiper.dart';
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
    var size = MediaQuery.of(context).size;
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Our products",
                    style: kTextStyle(
                      size: 18,
                      isBold: true,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Browse all",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FeedsWidget(),
          ],
        ),
      ),
    );
  }
}
