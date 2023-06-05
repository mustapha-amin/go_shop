import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/providers/cart_provider.dart';
import 'package:go_shop/providers/auth_service.dart';
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
  String text = """
  Anim voluptate ex cillum ex. Velit cillum anim velit quis aliqua nostrud laborum. Ut laborum esse et anim duis laboris ex eu magna. Nisi reprehenderit aute id adipisicing incididunt nostrud id ullamco id dolore officia. Excepteur ea magna anim reprehenderit veniam cillum esse irure culpa sunt aute. Labore nisi anim non ex ea cillum et sit laborum.

Est eiusmod et amet duis deserunt officia veniam voluptate amet. Cillum nostrud ut anim commodo Lorem id officia ut. Qui do eu incididunt non occaecat magna est non. Eu occaecat cupidatat magna excepteur fugiat nulla eu enim sunt velit aliqua. Laboris non excepteur cupidatat aliquip laborum ex qui cupidatat ea. Id minim exercitation esse tempor magna qui in consectetur ipsum exercitation laborum ex adipisicing. Qui culpa aliquip adipisicing magna labore non ipsum consequat adipisicing qui irure eu adipisicing. Elit do occaecat occaecat elit qui esse velit excepteur mollit. Sunt exercitation tempor labore ad sit. In reprehenderit ad veniam nisi mollit irure dolor consequat elit commodo laborum cillum. Non irure dolor exercitation cupidatat commodo. Aute irure pariatur nisi aliqua nisi officia amet exercitation eiusmod nostrud qui irure exercitation quis.

Proident pariatur dolor nulla veniam cillum laboris culpa minim aliqua sunt sint. Sit aute id commodo sit ad veniam eu eiusmod. Adipisicing voluptate sint culpa tempor aliquip tempor ea nisi laboris aliqua in ex est. Labore Lorem id ea non culpa irure anim excepteur incididunt anim labore ex dolor.
""";

  @override
  void initState() {
    _quantityController.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: widget.product!.hashCode,
                  transitionOnUserGestures: true,
                  child: SizedBox(
                    height: size.height / 2.4,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(widget.product!.imgPath!),
                        ),
                        Positioned(
                          left: -10,
                          child: Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Utils(context).color,
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
                        'N${widget.product!.price!}',
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
                style: kTextStyle(20, context, true),
              ),
              addVerticalSpacing(20),
              Text(
                text,
                style: kTextStyle(14, context),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
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
              onTap: () {
                if (authService.user!.isAnonymous) {
                  showErrorDialog(context, "You're not logged in");
                  return;
                }
                !cart.containsProduct(widget.product!)
                    ? {
                        cart.addToCart(CartItem(
                          product: widget.product,
                          quantity: 1,
                          price: widget.product!.price,
                        )),
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to cart"),
                            duration: Duration(milliseconds: 200),
                          ),
                        )
                      }
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Already in cart"),
                          duration: Duration(milliseconds: 200),
                        ),
                      );
              },
            ),
            AppButton(
                isElevated: true,
                width: size.width / 2.5,
                height: size.height / 15,
                labelText: "Buy now",
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
