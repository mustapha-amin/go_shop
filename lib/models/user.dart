import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:go_shop/models/cart_item.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GoShopUser {
  String? uid;
  String? name;
  String? email;
  int? phoneNumber;

  GoShopUser({this.uid, this.name, this.email, this.phoneNumber});

  GoShopUser copyWith({
    String? uid,
    String? name,
    String? email,
    int? phoneNumber,
    List<CartItem>? cart,
  }) {
    return GoShopUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory GoShopUser.fromMap(Map<String, dynamic> map) {
    return GoShopUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }

  @override
  String toString() {
    return 'GoShopUser(uid: $uid, name: $name, email: $email, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant GoShopUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ phoneNumber.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory GoShopUser.fromJson(String source) =>
      GoShopUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
