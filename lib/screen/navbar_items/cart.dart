import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/providers/cart_provider.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/cart_widget.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var customer = Provider.of<Customer?>(context);
    double total = customer!.cart!.fold(0,
        (previousValue, element) => previousValue + element.price!.toDouble());
    var size = MediaQuery.of(context).size;
    return customer!.cart!.isEmpty || AuthService().user!.isAnonymous
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/general/add-to-cart.png',
                  height: size.height / 3,
                  width: size.width / 2,
                ),
                Text(
                  "Your cart is empty",
                  style: GoogleFonts.lato(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          )
        : customer.cart == null
            ? const LoadingWidget()
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Cart (${customer.cart!.length})",
                  ),
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  foregroundColor: Colors.black,
                  actions: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text("Clear cart"),
                              content:
                                  const Text("Do you want to clear your cart?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    DatabaseService().clearCart();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      color: Colors.red,
                      icon: const Icon(Icons.delete_forever_sharp),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 3),
                            height: size.height / 17,
                            width: size.width / 3.3,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: Text(
                              "Order now",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            )),
                          ),
                          Text(
                            "Total: $nairaSymbol${total.toMoney}",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: customer.cart!.length,
                          itemBuilder: (context, index) {
                            var item = customer.cart![index];
                            return CartWidget(
                              cartItem: item,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
