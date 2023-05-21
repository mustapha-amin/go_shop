import 'package:flutter/material.dart';
import 'package:go_shop/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> myCart = [];
  int productCount = 0;
  int price = 0;

  void updateQuantity(CartItem item, int qty) {
    myCart.elementAt(myCart.indexOf(item)).quantity = qty;
    notifyListeners();
  }

  void refreshPrice() {
    price = 0;
    for (var i in myCart) {
      price += i.price!;
    }
    notifyListeners();
  }

  void addToCart(CartItem item) {
    myCart.add(item);
    refreshPrice();
    productCount = myCart.length;
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    myCart.remove(item);
    refreshPrice();
    productCount = myCart.length;
    notifyListeners();
  }

  void clearCart() {
    myCart = [];
    price = 0;
    notifyListeners();
  }
}
