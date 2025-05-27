import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:go_shop/models/order.dart';

class OrderRepository {
  final FirebaseFirestore firestore;
  OrderRepository({required this.firestore});

  Future<List<Order>> fetchOrders(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => Order.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }

  Future<void> createOrder(Order order) async {
    try {
      await firestore.collection('orders').doc(order.orderId).set(order.toMap());
    } catch (e) {
      throw Exception("Failed to create order: $e");
    }
  }
}
