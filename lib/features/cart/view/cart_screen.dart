import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cart Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
