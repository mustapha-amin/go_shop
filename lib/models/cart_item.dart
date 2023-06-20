import 'package:go_shop/models/product.dart';

class CartItem {
  Product? product;
  int? quantity;
  double? price;

  CartItem({this.product, this.quantity, this.price});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product?.toJson(),
      'quantity': quantity,
      'price': price,
    };
  }
}

