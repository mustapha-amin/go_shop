import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/collection_paths.dart';
import 'package:go_shop/models/order.dart';
import 'package:go_shop/services/dependencies.dart';

final fetchOrdersProvider = FutureProvider((ref) async {
  final snap = await locator
      .get<FirebaseFirestore>()
      .collection(CollectionPaths.orders)
      .where('userId', isEqualTo: locator.get<FirebaseAuth>().currentUser!.uid)
      .get();
    return snap.docs
      .map((doc) => Order.fromMap(doc.data()))
      .toList();
});
