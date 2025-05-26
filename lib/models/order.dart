import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/models/order_item.dart';

class Order {
  final String orderId;
  final String userId;
  final List<OrderItem> items;
  final Timestamp createdAt;
  final  double totalAmount;

  Order({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'createdAt': createdAt,
      'totalAmount': totalAmount,
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
      totalAmount: map['totalAmount']
    );
  }
}
