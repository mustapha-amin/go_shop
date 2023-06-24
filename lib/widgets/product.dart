import 'package:flutter/material.dart';
import 'package:go_shop/constants/extensions.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/shimmer.dart';
import '../constants/consts.dart';
import '../screen/inner_screens/product_detail.dart';

class ProductWidget extends StatefulWidget {
  Product? product;
  int? heroIndex;
  ProductWidget({super.key, this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String? wishListMsg;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Product? product = widget.product;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetail(
            product: product,
            heroTag: product!.id,
            
          );
        }));
      },
      child: Container(
        width: size.width / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.grey.withOpacity(0.1),
              blurStyle: BlurStyle.solid,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 5,
              child: Hero(
                transitionOnUserGestures: true,
                tag: widget.product!.id!,
                child: Image.network(widget.product!.imgPath!,
                    height: size.height / 7,
                    frameBuilder: (context, child, frame, _) {
                  if (frame == null) {
                    // fallback to placeholder
                    return ShimmerWidget(
                      height: size.height / 7,
                      width: size.width / 3,
                    );
                  }
                  return child;
                }),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product!.name!,
                    style: kTextStyle(
                      size: 15,
                    ),
                  ),
                  Text(
                    '$nairaSymbol${widget.product!.price!.toMoney}',
                    style: kTextStyle(
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
