import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/screen/inner_screens/order_screen.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/widgets/cart_widget.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/cart_item.dart';
import '../../models/customer.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    var customer = Provider.of<Customer?>(context);
    double total = customer!.cart!.isNotEmpty
        ? customer.cart!.fold(
            0,
            (previousValue, element) =>
                previousValue + element.totalPrice!.toDouble())
        : 0;
    var size = MediaQuery.of(context).size;
    return customer.cart!.isEmpty || AuthService().user!.isAnonymous
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
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Colors.black,
              title: Text(
                "Cart",
                style: kTextStyle(size: 20, isBold: true),
              ),
              actions: [
                TextButton(
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
                  child: Text(
                    "Clear cart",
                    style: kTextStyle(size: 15, color: Colors.red),
                  ),
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
                      ElevatedButton.icon(
                        label: Text(
                          "Checkout (${selectedItems.length})",
                          style: kTextStyle(
                            size: 16,
                            color: Colors.white,
                            isBold: true,
                          ),
                        ),
                        icon: const Icon(Icons.shopping_cart_checkout),
                        onPressed: () {
                          selectedItems.isEmpty
                              ? null
                              : Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                  return OrderScreen(
                                    items: selectedItems,
                                  );
                                }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              selectedItems.isEmpty ? Colors.grey : null,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
                        return Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                value: selectedItems.contains(item),
                                onChanged: (val) {
                                  setState(() {
                                    val!
                                        ? selectedItems.add(item)
                                        : selectedItems.remove(item);
                                  });
                                },
                              ),
                            ),
                            CartWidget(
                              cartItem: item,
                            ),
                          ],
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
