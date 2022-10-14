import 'package:flutter/material.dart';
import 'package:go_shop/screen/cart.dart';
import 'package:go_shop/screen/categories.dart';
import 'package:go_shop/screen/homescreen.dart';

import 'user.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 1;
  final List pages = const [
    HomeScreen(),
    Categories(),
    Cart(),
    User(),
  ];

  void selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: selectPage,
        currentIndex: _selectedIndex,
        items:  [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'category',
            icon: Icon(_selectedIndex == 1 ? Icons.category : Icons.category_outlined),
          ),
          BottomNavigationBarItem(
            label: 'cart',
            icon: Icon(_selectedIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
          ),
          BottomNavigationBarItem(
            label: 'user',
            icon: Icon(_selectedIndex == 3 ? Icons.account_circle_rounded : Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}
