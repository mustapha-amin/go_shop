import 'package:flutter/material.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../screen/inner_screens/product_detail.dart';

class ProductWidget extends StatefulWidget {
  Product? product;
  ProductWidget({super.key, this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String? wishListMsg;

  @override
  Widget build(BuildContext context) {
    var wishlist = Provider.of<WishlistProvider>(context, listen: true);
    var size = MediaQuery.of(context).size;
    Product? product = widget.product;
    return GestureDetector(
      onTap: () {
        debugPrint(wishlist.containsProduct(product) ? "true" : "false");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetail(
            product: product,
          );
        }));
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: size.height / 4,
          minWidth: size.width / 2,
        ),
        child: Card(
          color: Utils(context).isDark ? Colors.grey[800] : Colors.grey[100],
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(product!.discounted ? 6.0 : 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                addVerticalSpacing(3),
                Image.asset(
                  product.imgPath!,
                  height: size.height / (product.discounted ? 12 : 8),
                  fit: BoxFit.fill,
                ),
                addVerticalSpacing(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'N${product.price}',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                          ),
                        ),
                        product.discounted
                            ? const Text(
                                "N100,000",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )
                            : addVerticalSpacing(0),
                      ],
                    ),
                    addHorizontalSpacing(10),
                    InkWell(
                      onTap: () {
                        wishlist.containsProduct(product)
                            ? wishlist.removeFromWishlist(widget.product!)
                            : wishlist.addToWishlist(widget.product!);
                        setState(() {
                          !wishlist.containsProduct(product)
                              ? wishListMsg = "Removed from wishlist"
                              : wishListMsg = "Added to wishlist";
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(wishListMsg!),
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Icon(
                        wishlist.containsProduct(product)
                            ? Icons.shopping_bag
                            : Icons.shopping_bag_outlined,
                        color:
                            Utils(context).isDark ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
