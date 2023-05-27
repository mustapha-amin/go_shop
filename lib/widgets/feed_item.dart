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
  String? text = "The framework can call this method multiple times over the lifetime of a [StatefulWidget]. For example, if the widget is inserted into the tree in multiple locations, the framework will create a separate [State] object for each location";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: ProductWidget(
              product: Product(
                name: "Airpod",
                imgPath: '$basePath/laptop.png',
                price: 45000,
                description: text,
                discounted: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
