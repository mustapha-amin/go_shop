import 'dart:developer';

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
    try {
      final user = await ref.read(currentUserNotifierProvider.future);
      final Customer customer = Customer(
        name: user.name,
        phoneNumber: "0${user.phoneNumber}",
        email: user.email!,
      );
      final Flutterwave flutterwave = Flutterwave(
        publicKey: "FLWPUBK_TEST-d893537000c653d360f64e124f4e31af-X",
        currency: "NGN",
        redirectUrl: ' "https://www.flutterwave.com"',
        txRef: "tx-${const Uuid().v4()}",
        amount: "3000",
        customer: customer,
        paymentOptions: "ussd, card, bank transfer",
        customization: Customization(title: "My Payment"),
        isTestMode: true,
      );

      final ChargeResponse response = await flutterwave.charge(context);
      if (response.success!) {
        await locator
            .get<FirebaseFirestore>()
            .collection('orders')
            .doc(response.txRef)
            .set(order.copyWith(orderId: response.txRef, status: 'Paid').toMap());
        return "Payment successful: ${response.txRef}";
      } else {
        return "Payment failed";
      }
    } on Exception catch (e) {
      log(e.toString());
      throw Exception("An error occured while making payment making payment");
    }
  }
}
