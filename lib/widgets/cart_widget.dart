import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/widgets/shimmer.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../services/utils.dart';

class CartWidget extends StatefulWidget {
  CartItem? cartItem;

  CartWidget({super.key, this.cartItem});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityController = TextEditingController();
  ValueNotifier<bool> buttonTapped = ValueNotifier<bool>(false);
  

  @override
  void initState() {
    _quantityController.text = widget.cartItem!.quantity.toString();
    super.initState();
  }

  void increment() {
    buttonTapped.value = true;
    int quantity = int.parse(_quantityController.text);
    quantity < 20 ? quantity++ : null;
    _quantityController.text = quantity.toString();
  }

  void decrement() {
    buttonTapped.value = true;
    int quantity = int.parse(_quantityController.text);
    quantity > 1 ? quantity-- : null;
    _quantityController.text = quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var product = widget.cartItem!.product;
    return SizedBox(
      height: 23.h,
      width: size.width,
      child: Card(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product!.imgPath!,
                  width: 30.w,
                  height: 15.h,
                  fit: BoxFit.fill,
                  frameBuilder: (context, child, frame, _) {
                    if (frame == null) {
                      // fallback to placeholder
                      return ShimmerWidget(
                        height: size.height / 7,
                        width: size.width / 3,
                      );
                    }
                    return child;
                  },
                ),
              ),
              addHorizontalSpacing(5.w),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      style: kTextStyle(
                        size: 20,
                      ),
                    ),
                    Text(
                      '$nairaSymbol${widget.cartItem!.totalPrice!.toMoney}',
                      style: kTextStyle(
                        size: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: decrement,
                          child: Container(
                            width: 15.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[100],
                              border: Border.all(
                                color: Colors.red,
                              ),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 5.w,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: increment,
                          child: Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[100],
                              border: Border.all(
                                color: Colors.green,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 5.w,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.sp),
                          child: ValueListenableBuilder(
                            valueListenable: buttonTapped,
                            builder: (_, value, __) {
                              return GestureDetector(
                                onTap: () async {
                                  value == true
                                      ? await DatabaseService()
                                          .updateCartProductQuantity(
                                              product.id,
                                              int.parse(
                                                  _quantityController.text))
                                      : await DatabaseService()
                                          .deleteFromCart(widget.cartItem!);
                                  buttonTapped.value = false;
                                },
                                child: Icon(
                                  value == true ? Icons.check : Icons.delete,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
