import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/models/product.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository({required this.firestore});

  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await firestore.collection('products').get();
      log(snapshot.docs[0].data().toString());
      return snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    } catch (e) {
      log(e.toString(), stackTrace: StackTrace.current);
      throw Exception('Failed to load products');
    }
  }
}
