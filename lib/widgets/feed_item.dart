import 'package:flutter/material.dart';
import 'package:go_shop/models/category_model.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/widgets/product.dart';

class FeedsWidget extends StatefulWidget {
  Product? product;
  FeedsWidget({Key? key, this.product}) : super(key: key);
  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  static String basePath = 'assets/images/offers';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: size.width / (size.height * 0.55),
        children: List.generate(
          10,
          (index) => ProductWidget(
            product: Product(
              name: "Airpod",
              imgPath: '$basePath/airpod.png',
              price: 45000,
              discounted: false,
            ),
          ),
        ),
      ),
    );
  }
}
