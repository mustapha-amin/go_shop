import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/screen/inner_screens/on_sale.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/product.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/feed_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
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
