import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/screen/auth/username.dart';
import 'package:go_shop/screen/inner_screens/payment_successful.dart';
import 'package:go_shop/screen/navbar_items/cart.dart';
import 'package:go_shop/screen/navbar_items/categories.dart';
import 'package:go_shop/screen/navbar_items/homescreen.dart';
import 'package:go_shop/providers/auth_service.dart';
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
  late int _selectedIndex;
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
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Customer?>(context);
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
                    top: 1,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        cartProvider == null
                            ? ""
                            : cartProvider.cart!.length.toString(),
                        style: kTextStyle(
                          size: 9,
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
