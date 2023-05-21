import 'package:flutter/material.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/providers/cart_provider.dart';
import 'package:go_shop/services/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    _quantityController.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int priceByQty = widget.product!.price! *
        int.parse(_quantityController.text);
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: size.height / 2.4,
                    child: Image.asset(widget.product!.imgPath!),
                  ),
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
                              color: Colors.green[800],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            int qty =
                                int.tryParse(_quantityController.text) as int;
                            qty <= 1 ? null : qty--;
                            _quantityController.text = qty.toString();
                          });
                        },
                        child: const Icon(Icons.remove),
                      ),
                      SizedBox(
                        width: size.width / 6,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextField(
                            style: TextStyle(
                              color: Utils(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            onChanged: (_) {
                              _quantityController.text == '1'
                                  ? null
                                  : setState(() {});
                            },
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            int qty =
                                int.tryParse(_quantityController.text) as int;
                            qty < 10 ? qty++ : null;
                            _quantityController.text = qty.toString();
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total",
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              color: Colors.red,
                            ),
                          ),
                          Text("N$priceByQty"),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          cart.addToCart(
                            CartItem(
                              product: widget.product,
                              quantity: int.parse(_quantityController.text),
                              price: widget.product!.price !* int.parse(_quantityController.text),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Added to cart"),
                              duration: Duration(milliseconds: 400),
                            ),
                          );
                        },
                        child: Text("Add to Cart"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              child: IconButton(
                color: Colors.grey[700],
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
