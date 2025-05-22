import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GoShopUser {
  String? uid;
  String? name;
  String? email;
  int? phoneNumber;
  List<String> cart;

  GoShopUser({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    required this.cart,
  });

  GoShopUser copyWith({
    String? uid,
    String? name,
    String? email,
    int? phoneNumber,
    List<String>? cart,
  }) {
    return GoShopUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'cart': cart,
    };
  }

  factory GoShopUser.fromMap(Map<String, dynamic> map) {
    return GoShopUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      cart: List<String>.from(map['cart']) ?? [],
    );
  }

  @override
  String toString() {
    return 'GoShopUser(uid: $uid, name: $name, email: $email, phoneNumber: $phoneNumber, cart: $cart)';
  }

  @override
  bool operator ==(covariant GoShopUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        cart.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory GoShopUser.fromJson(String source) =>
      GoShopUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
