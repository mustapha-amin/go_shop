import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/models/cart_item.dart';
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
                      style: kTextStyle(size: 20, context: context),
                    ),
                    Text(
                      '$nairaSymbol${product.price!.toMoney}',
                      style: kTextStyle(size: 15, context: context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 15.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 5.w,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 15.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 5.w,
                          ),
                        ),
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
