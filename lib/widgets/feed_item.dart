import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_shop/models/category_model.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:go_shop/widgets/product.dart';
import 'package:provider/provider.dart';

import '../services/database.dart';

class FeedsWidget extends StatefulWidget {
  FeedsWidget({Key? key}) : super(key: key);
  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Iterable<Product>>(context).toList();
    products.shuffle();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ProductWidget(
            product: products.elementAt(index),
          ),
        );
      },
    );
  }
}
