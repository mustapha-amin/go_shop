import 'package:flutter/material.dart';
import 'package:go_shop/widgets/product.dart';

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
          
        ],
      ),
    );
  }
}
