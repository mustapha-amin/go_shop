import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/models/product.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository({required this.firestore});

  Future<List<Product>> getProducts() async {
    try {
      log('Starting to fetch products...');
      final snapshot = await firestore.collection('products').get();
      log('Fetched ${snapshot.docs.length} documents from Firestore');

      if (snapshot.docs.isEmpty) {
        log('No products found in Firestore');
        return [];
      }

      // Log each document ID and data
      for (var doc in snapshot.docs) {
        log('Document ID: ${doc.id}');
        log('Document Data: ${doc.data()}');
      }

      final products =
          snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
      log('Converted ${products.length} documents to Product objects');

      // Log unique product IDs to check for duplicates
      final uniqueIds = products.map((p) => p.id).toSet();
      log('Unique product IDs: ${uniqueIds.length}');
      if (uniqueIds.length != products.length) {
        log(
          'WARNING: Found duplicate products! Total: ${products.length}, Unique: ${uniqueIds.length}',
        );
      }

      return products;
    } catch (e) {
      log('Failed to load products', error: e, stackTrace: StackTrace.current);
      throw Exception('Failed to load products: ${e.toString()}');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      log('Fetching product with ID: $id');
      final snapshot = await firestore.collection('products').doc(id).get();
      if (!snapshot.exists) {
        log('Product not found with ID: $id');
        throw Exception('Product not found');
      }
      log('Found product data: ${snapshot.data()}');
      return Product.fromMap(snapshot.data()!);
    } catch (e) {
      log(
        'Failed to load product: $id',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw Exception('Failed to load product: ${e.toString()}');
    }
  }
}
