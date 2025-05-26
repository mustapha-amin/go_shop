import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:go_shop/core/providers.dart';
import 'package:go_shop/models/order.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:uuid/uuid.dart';

class PaymentRepository {
  Future<String> handlePaymentInitialization(
    BuildContext context,
    WidgetRef ref,
    Order order,
  ) async {
    final user = ref.read(currentUserNotifierProvider.notifier).currentUser;
    final Customer customer = Customer(
      name: user.name,
      phoneNumber: "0${user.phoneNumber}",
      email: user.email!,
    );
    final Flutterwave flutterwave = Flutterwave(
      publicKey: "FLWPUBK_TEST-b9112b5efc7d2b4dcc99c905674beb1f-X",
      currency: "₦",
      redirectUrl: '/home',
      txRef: "tx-${const Uuid().v4()}",
      amount: "3000",
      customer: customer,
      paymentOptions: "ussd, card, bank transfer",
      customization: Customization(title: "My Payment"),
      isTestMode: true,
    );

    final ChargeResponse response = await flutterwave.charge(context);

    if (response.success == true) {
      await locator
          .get<FirebaseFirestore>()
          .collection('orders')
          .doc(response.txRef)
          .set(order.toMap());
      return "Payment successful: ${response.txRef}";
    } else {
      return "Payment failed";
    }
  }
}
