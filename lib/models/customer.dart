import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/models/cart_item.dart';

class Customer {
  String? name;
  String? email;
  List<CartItem>? cart;
  List? orders;
  DateTime? createdAt;

  Customer({this.name, this.email, this.cart, this.orders, this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "cart": [],
      "orders": [],
      "createdAt": createdAt,
    };
  }

  static Customer fromJson(Map<String, dynamic> json) {
    return Customer(
        name: json["name"] as String,
        email: json["email"] as String,
        cart: (json['cart'] as List<dynamic>)
          .map((itemJson) => CartItem.fromJson(itemJson))
          .toList(),
        orders: json["orders"] as List,
        createdAt: (json["createdAt"] as Timestamp).toDate());
  }

  Customer copyWith({
    String? name,
    String? email,
    List<CartItem>? cart,
    List? orders,
    DateTime? createdAt,
  }) {
    return Customer(
      name: name ?? this.name,
      email: email ?? this.email,
      cart: cart ?? this.cart,
      orders: orders ?? this.orders,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
