import 'package:flutter/material.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/utils.dart';

class CartWidget extends StatefulWidget {
  CartItem? cartItem;

  CartWidget({super.key, this.cartItem});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    _quantityController.text = widget.cartItem!.quantity.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var product = widget.cartItem!.product;
    return SizedBox(
      height: size.height / 5,
      width: size.width,
      child: Card(
        color: Colors.grey[100],
        child: Row(
          children: [
            Image.asset(
              product!.imgPath!,
              width: size.width / 3.4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name!,
                  style: GoogleFonts.lato(
                    fontSize: 25,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          minimumSize: Size(size.width / 8, size.height / 20),
                          elevation: 0,
                          backgroundColor:  Colors.grey[100],
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: size.width / 9,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color:  Colors.black,
                            ),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          shape: const CircleBorder(),
                          minimumSize: Size(size.width / 8, size.height / 20),
                          elevation: 0,
                        ),
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              title: Text(
                                "Clear cart",
                              ),
                              content: Text(
                                  "Do you want to remove this product from your cart?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    
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
                      icon: Icon(
                        Icons.delete_forever,
                        size: 35,
                        color:  Colors.red,
                      )),
                  Text('N${widget.cartItem!.price}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
