import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/services/auth_service.dart';

class DatabaseService {
  static const collection = "customers";
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  AuthService? authService;
  DatabaseService({this.authService});

  Future<void> createCustomer() async {
    Customer customer = Customer(
      name: authService!.user!.displayName,
      email: authService!.user!.email,
      cart: [],
      wishlist: [],
      createdAt: DateTime.now(),
    );
    await _firebaseFirestore
        .collection(collection)
        .doc(authService!.userid)
        .set(customer.toJson());
  }
  
}
