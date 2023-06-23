import 'package:go_shop/models/product.dart';

class CartItem {
  Product? product;
  int? quantity;
  double? basePrice;
  double? totalPrice;

  CartItem({this.product, this.quantity, this.basePrice, this.totalPrice});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      basePrice: json['basePrice'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product?.toJson(),
      'quantity': quantity,
      'basePrice': basePrice,
      'totalPrice': basePrice! * quantity!,
    };
  }
}
