import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/product.dart';

class Customer {
  String? id;
  String? name;
  String? email;
  List<CartItem>? cart;
  List<Product>? favorites;
  DateTime? createdAt;

  Customer({this.id, this.name, this.email, this.cart, this.favorites, this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "cart": [],
      "favorites": [],
      "createdAt": createdAt,
    };
  }

  static Customer fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
        name: json["name"] as String,
        email: json["email"] as String,
        cart: (json['cart'] as List<dynamic>)
            .map((itemJson) => CartItem.fromJson(itemJson))
            .toList(),
        // favorites: (json["favorites"] as List<dynamic>)
        //     .map((item) => Product.fromJson(item))
        //     .toList(),
        createdAt: (json["createdAt"] as Timestamp).toDate());
  }

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    List<CartItem>? cart,
    List<Product>? favorites,
    DateTime? createdAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      cart: cart ?? this.cart,
      favorites: favorites ?? this.favorites,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
