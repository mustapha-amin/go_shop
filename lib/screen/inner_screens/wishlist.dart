import 'package:flutter/material.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/product.dart';
import 'package:provider/provider.dart';

import '../../providers/wishlist_provider.dart';

class WishlistScreen extends StatefulWidget {
  static const routeName = '/wishlistScreen';
  const WishlistScreen({Key? key}) : super(key: key);
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var wishlist = Provider.of<WishlistProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
      ),
      body: wishlist.wishlist.isEmpty
          ? Column(
              children: [
                Image.asset(
                  Utils(context).isDark
                      ? 'assets/images/general/wishlist_dark.png'
                      : 'assets/images/general/wishlist_light.png',
                  height: size.height / 1.5,
                  width: size.width,
                ),
                Text("Your wishlist is empty")
              ],
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.55),
              shrinkWrap: true,
              children: [
                ...wishlist.wishlist.map(
                  (e) => ProductWidget(
                    product: e,
                  ),
                ),
              ],
            ),
    );
  }
}
