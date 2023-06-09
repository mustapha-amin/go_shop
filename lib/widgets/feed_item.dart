import 'package:flutter/material.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:go_shop/widgets/product.dart';

import '../services/database.dart';

class FeedsWidget extends StatefulWidget {
  FeedsWidget({Key? key}) : super(key: key);
  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    return StreamBuilder<List<Product>?>(
      stream: databaseService.getProducts('laptops'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = snapshot.data!;
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
                  product: products[index],
                ),
              );
            },
          );
        }
        return const Center(
          child: LoadingWidget(),
        );
      },
    );
  }
}
