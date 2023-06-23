import 'package:flutter/material.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/widgets/product.dart';
import 'package:provider/provider.dart';

class FeedsWidget extends StatefulWidget {
  Iterable<Product>? products;
  FeedsWidget({this.products, Key? key}) : super(key: key);
  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  @override
  void initState() {
    widget.products!.toList().shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.products!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ProductWidget(
            product: widget.products!.elementAt(index),
          ),
        );
      },
    );
  }
}
