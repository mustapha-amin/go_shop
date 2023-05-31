import 'package:flutter/material.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/services/utils.dart';
import 'package:provider/provider.dart';
import '../constants/consts.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../screen/inner_screens/product_detail.dart';

class ProductWidget extends StatefulWidget {
  Product? product;
  int? heroIndex;
  ProductWidget({super.key, this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String? wishListMsg;

  @override
  Widget build(BuildContext context) {
    var wishlist = Provider.of<WishlistProvider>(context);
    var cart = Provider.of<CartProvider>(context);
    var size = MediaQuery.of(context).size;
    Product? product = widget.product;
    return GestureDetector(
      onTap: () {
        debugPrint(cart.myCart.contains(product).toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetail(
            product: product,
          );
        }));
      },
      child: Container(
        width: size.width / 2,
        decoration: BoxDecoration(
          color: Utils(context).isDark ? Colors.grey[800] : Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.grey.withOpacity(0.1),
              blurStyle: BlurStyle.solid,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
                top: 10,
                right: 5,
                child: IconButton(
                  icon: Icon(
                    wishlist.containsProduct(widget.product!)
                        ? Icons.shopping_bag
                        : Icons.shopping_bag_outlined,
                    color: Utils(context).isDark
                        ? Colors.white
                        : Colors.black.withOpacity(0.1),
                    size: 30,
                    shadows: const [
                      Shadow(
                        blurRadius: 0.5,
                      )
                    ],
                  ),
                  onPressed: () {
                    wishlist.containsProduct(widget.product!)
                        ? wishlist.removeFromWishlist(widget.product!)
                        : wishlist.addToWishlist(widget.product!);
                  },
                )),
            Positioned(
              top: 10,
              left: 5,
              child: Hero(
                transitionOnUserGestures: true,
                tag: widget.product.hashCode,
                child: Image.asset(
                  widget.product!.imgPath!,
                  height: size.height / 7,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product",
                    style: kTextStyle(20, context),
                  ),
                  Text(
                    "N10,000",
                    style: kTextStyle(15, context),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
