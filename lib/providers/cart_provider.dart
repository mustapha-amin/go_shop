import 'package:flutter/material.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> myCart = [];
  int _productCount = 0;
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
    notifyListeners();
  }

  void removeFromCart(Product product) {
    myCart.removeWhere((element) => element.product == product);
    refreshPrice();
    notifyListeners();
  }

  void clearCart() {
    myCart = [];
    price = 0;
    notifyListeners();
  }

  bool containsProduct(Product product) {
    return myCart.any((element) => element.product!.id == product.id);
  }

  int get productsCount => myCart.length;
}
