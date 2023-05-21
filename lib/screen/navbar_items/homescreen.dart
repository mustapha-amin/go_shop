import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/screen/inner_screens/on_sale.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/product.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/category_model.dart';
import '../../widgets/feed_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String basePath = 'assets/images/offers';
  List<Product> products = [
    Product(
      name: "Nike air",
      imgPath: '$basePath/shoe.png',
      discounted: true,
      price: 80000,
      
    ),
    Product(
      name: "T-shirt",
      imgPath: '$basePath/shirt.png',
      discounted: true,
      price: 75000,
    ),
    Product(
      name: "HP laptop",
      imgPath: '$basePath/laptop.png',
      discounted: true,
      price: 90000,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 3,
              child: Swiper(
                itemBuilder: (context, index) {
                  return Image.asset(
                    products[index].imgPath!,
                    fit: BoxFit.contain,
                  );
                },
                autoplay: true,
                itemCount: products.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.redAccent,
                  ),
                ),
                control: const SwiperControl(),
              ),
            ),
            addVerticalSpacing(6),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, DiscountScreen.routeName);
              },
              child: const Text(
                "View all",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      Text(
                        "30% off",
                        style: GoogleFonts.abel(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.discount_outlined,
                        color:
                            Utils(context).isDark ? Colors.white : Colors.red,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: size.height / 4.6,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...products.map(
                          (e) => ProductWidget(
                            product: e,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Our products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
