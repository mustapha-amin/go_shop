import 'package:go_shop/models/product.dart';

class CartItem {
  Product? product;
  int? quantity;
  int? price;

  CartItem({this.product, this.quantity, this.price});
}
