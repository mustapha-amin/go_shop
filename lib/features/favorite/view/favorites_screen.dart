import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  static const route = '/fave';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Favorites Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
