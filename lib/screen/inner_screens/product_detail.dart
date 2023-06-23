import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/providers/cart_provider.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/error_dialog.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';

class ProductDetail extends StatefulWidget {
  Product? product;
  ProductDetail({super.key, this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 0;
  TextEditingController _quantityController = TextEditingController();
  bool heartIsTapped = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    _quantityController.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cartProvider = Provider.of<Customer?>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Hero(
                    tag: widget.product!.hashCode,
                    transitionOnUserGestures: true,
                    child: SizedBox(
                      height: size.height / 2.4,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.network(widget.product!.imgPath!),
                          ),
                          Positioned(
                            left: -10,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product!.name!,
                          style: GoogleFonts.lato(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₦${widget.product!.price!.toMoney}',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          heartIsTapped = !heartIsTapped;
                        });
                      },
                      icon: Icon(
                        heartIsTapped
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 35,
                      ),
                    )
                  ],
                ),
                addVerticalSpacing(20),
                Text(
                  "Product description",
                  style: kTextStyle(size: 20, isBold: true),
                ),
                addVerticalSpacing(20),
                Text(
                  widget.product!.description!,
                  style: kTextStyle(
                    size: 14,
                  ),
                ),
              ],
            )),
            SizedBox(
              width: size.width,
              height: size.height / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                      isElevated: true,
                      width: size.width / 2.5,
                      height: size.height / 15,
                      labelText: "Add to cart",
                      onTap: () async {
                        if (authService.user!.isAnonymous) {
                          showErrorDialog(context, "You're not logged in");
                        } else {
                          cartProvider!.cart!.any((element) =>
                                      element.product!.id !=
                                      widget.product!.id) ||
                                  cartProvider.cart!.isEmpty
                              ? await DatabaseService()
                                  .addToCart(
                                    CartItem(
                                      product: widget.product,
                                      quantity: 1,
                                      price: widget.product!.price,
                                    ),
                                  )
                                  .whenComplete(() =>
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Added to cart"),
                                          duration: Duration(milliseconds: 800),
                                        ),
                                      ))
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Already in cart"),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );
                          // ignore: use_build_context_synchronously
                        }
                      }),
                  AppButton(
                      isElevated: true,
                      width: size.width / 2.5,
                      height: size.height / 15,
                      labelText: "Buy now",
                      onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
