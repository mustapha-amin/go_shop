import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:go_shop/global_products.dart';
import 'package:go_shop/widgets/product.dart';

import '../../models/product.dart';

class DiscountScreen extends StatefulWidget {
  static const routeName = '/discountScreen';
  const DiscountScreen({Key? key}) : super(key: key);
  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: size.width / (size.height * 0.45),
        shrinkWrap: true,
        children: [
          ...GlobalProducts.products.map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductWidget(
                product: e,
              ),
            ),
          )
        ],
      ),
    );
  }
}
