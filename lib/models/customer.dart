import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? name;
  String? email;
  List? cart;
  List? wishlist;
  DateTime? createdAt;

  Customer({this.name, this.email, this.cart, this.wishlist, this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "cart": [],
      "wishlist": [],
      "createdAt": createdAt,
    };
  }

  static Customer fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json["name"] as String,
      email: json["email"] as String,
      cart: json["cart"] as List,
      wishlist: json["wishlist"] as List,
      createdAt: (json["createdAt"] as Timestamp).toDate()
    );
  }
}
