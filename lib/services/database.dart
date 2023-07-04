import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/category_model.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/services/utils.dart';
import 'package:uuid/uuid.dart';
import '../models/featured_products.dart';
import '../models/product.dart';
import '../models/order_model.dart' as k;

class DatabaseService {
  static const customersCollection = "customers";
  static const productsCollection = "products";
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static AuthService? authService = AuthService();

  Future<void> createCustomer() async {
    Customer customer = Customer(
      id: authService!.userid,
      name: authService!.user!.displayName,
      email: authService!.user!.email,
      cart: [],
      createdAt: DateTime.now(),
    );
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .set(customer.toJson());
  }

  Future<void> updateUserInfo(Customer customer) async {
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .set(customer.toJson());
  }

  Future<void> deleteAccount() async {
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .delete();
  }

  Stream<List<Category>> getCategories() {
    return _firebaseFirestore.collection('categories').snapshots().map(
        (snap) => snap.docs.map((e) => Category.fromJson(e.data())).toList());
  }

  static Stream<Customer> getCustomer() {
    if (FirebaseAuth.instance.currentUser != null) {
      return _firebaseFirestore
          .collection(customersCollection)
          .doc(authService!.userid)
          .snapshots()
          .map((snap) => Customer.fromJson(snap.data()!));
    } else {
      return const Stream.empty();
    }
  }

  Future<void> addToCart(CartItem cartItem) async {
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .update({
      'cart': FieldValue.arrayUnion([cartItem.toJson()]),
    });
  }

  Future<void> deleteFromCart(CartItem cartItem) async {
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .update({
      'cart': FieldValue.arrayRemove([cartItem.toJson()])
    });
  }

  Future<void> clearCart() async {
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .update({
      'cart': [],
    });
  }

  Stream<Iterable<Product>> fetchProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snap) => snap.docs.map((e) => Product.fromJson(e.data())));
  }

  Future<void> updateCartProductQuantity(
      BuildContext context, String? id, int newQuantity) async {
    try {
      final doc = await _firebaseFirestore
          .collection(customersCollection)
          .doc(authService!.userid)
          .get();
      final customer = Customer.fromJson(doc.data()!);
      final cartItem =
          customer.cart!.firstWhere((element) => element.product!.id == id);
      final cartItemIndex = customer.cart!.indexOf(cartItem);
      customer.cart![cartItemIndex].quantity = newQuantity;

      await _firebaseFirestore
          .collection(customersCollection)
          .doc(authService!.userid)
          .update({
        'cart': customer.cart!.map((element) => element.toJson()).toList(),
      });
    } catch (e) {
      showSnackbar(context, "An error occured");
    }
  }

  Stream<List<FeaturedProduct>> fetchFeaturedProducts() {
    return _firebaseFirestore.collection('featured').snapshots().map((snap) =>
        snap.docs.map((e) => FeaturedProduct.fromJson(e.data())).toList());
  }

  Future<void> createAnOrder(BuildContext context, k.Order order) async {
    order.orderID = const Uuid().v4();
    try {
      await _firebaseFirestore
          .collection('orders')
          .doc(order.orderID)
          .set(order.toJson());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
        padding: const EdgeInsets.all(10),
      ));
    }
  }

  Stream<List<k.Order>> fetchOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('customerID', isEqualTo: authService!.userid)
        .snapshots()
        .map((snap) =>
            snap.docs.map((e) => k.Order.fromJson(e.data())).toList());
  }

  Future<Product> fetchProductsByID(String? id) async {
    final doc = await _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: id)
        .get();
    return Product.fromJson(doc.docs.first.data());
  }
}
