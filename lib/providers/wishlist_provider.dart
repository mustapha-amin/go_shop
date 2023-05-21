import 'package:flutter/material.dart';
import 'package:go_shop/models/product.dart';

class WishlistProvider extends ChangeNotifier {
  List<Product> wishlist = [];

  void addToWishlist(Product product) {
    wishlist.contains(product) ? null : wishlist.add(product);
    notifyListeners();
  }

  void removeFromWishlist(Product product) {
    wishlist.remove(product);
    notifyListeners();
  }

  bool containsProduct(Product product) {
    return wishlist.contains(product);
  }
}
