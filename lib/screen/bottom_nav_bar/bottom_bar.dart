import 'package:flutter/material.dart';
import 'package:go_shop/providers/cart_provider.dart';
import 'package:go_shop/screen/navbar_items/cart.dart';
import 'package:go_shop/screen/navbar_items/categories.dart';
import 'package:go_shop/screen/navbar_items/homescreen.dart';
import 'package:go_shop/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../navbar_items/user.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = "/bottomBarScreen";
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  AuthService authService = AuthService();
  int _selectedIndex = 0;
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
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: selectPage,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'category',
            icon: Icon(
                _selectedIndex == 1 ? Icons.category : Icons.category_outlined),
          ),
          BottomNavigationBarItem(
              label: 'cart',
              icon: Stack(
                children: [
                  Icon(
                    _selectedIndex == 2
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                  ),
                  Positioned(
                    top: -3,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[600],
                      ),
                      child: Text(
                        cart.myCart.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )),
          BottomNavigationBarItem(
            label: 'user',
            icon: Icon(_selectedIndex == 3
                ? Icons.account_circle_rounded
                : Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}
