import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/services/auth_service.dart';

class DatabaseService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  AuthService? _authService;

  Future<void> createCustomer() async {
    await _firebaseFirestore.collection("customers").doc(_authService!.userid).set({
      "name": _authService!.userid,
      "email": _authService!.user!.email,
      "cart": [],
      "wishlist": [],
      "createdAt": Timestamp.now(),
    });
  }
}
