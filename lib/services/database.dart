import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/category_model.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/providers/auth_service.dart';

import '../models/product.dart';

class DatabaseService {
  static const customersCollection = "customers";
  static const productsCollection = "products";
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static AuthService? authService = AuthService();

  Future<void> createCustomer() async {
    Customer customer = Customer(
      name: authService!.user!.displayName,
      email: authService!.user!.email,
      cart: [],
      orders: [],
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

  Stream<List<Product>> getProducts(String? categoryId) {
    return _firebaseFirestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .snapshots()
        .map(
          (snap) => snap.docs.map((e) => Product.fromJson(e.data())).toList(),
        );
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
      'cart': FieldValue.arrayUnion([cartItem]),
    });
  }

  Future<void> makeAnOrder(CartItem cartItem) async {
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .update({
      'order': FieldValue.arrayUnion([cartItem]),
    });
  }

  Future<void> deleteFromCart(Product product) async {
    await _firebaseFirestore
        .collection(customersCollection)
        .doc(authService!.userid)
        .update({
      'cart': FieldValue.arrayRemove([product])
    });
  }
}
