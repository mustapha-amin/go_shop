import 'package:flutter/material.dart';
import 'package:go_shop/providers/cart_provider.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/cart_widget.dart';
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
    var customer = Provider.of<Customer>(context);
    var size = MediaQuery.of(context).size;
    return customer.cart!.isEmpty
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
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Cart (${customer.cart!.length})",
                style: TextStyle(
                  color: Utils(context).color,
                ),
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
                          backgroundColor: Utils(context).isDark
                              ? Colors.grey[600]
                              : Colors.white,
                          title: const Text("Clear cart"),
                          content:
                              const Text("Do you want to clear your cart?"),
                          actions: [
                            TextButton(
                              onPressed: () {
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
                        "Total: ",
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
