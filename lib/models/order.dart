// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:go_shop/models/order_item.dart';

class Order {
  final String orderId;
  final String userId;
  final List<OrderItem> items;
  final Timestamp createdAt;
  final  double totalAmount;
  final String status;

  Order({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.totalAmount,
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'createdAt': createdAt,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      items:
          (map['items'] as List<dynamic>)
              .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
              .toList(),
      createdAt:
          map['createdAt'] is Timestamp
              ? map['createdAt'] as Timestamp
              : Timestamp.fromMillisecondsSinceEpoch(map['createdAt']),
      totalAmount: map['totalAmount'],
      status: map['status'] ?? 'pending',
    );
  }

  Order copyWith({
    String? orderId,
    String? userId,
    List<OrderItem>? items,
    Timestamp? createdAt,
    double? totalAmount,
    String? status,
  }) {
    return Order(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
    );
  }
}
