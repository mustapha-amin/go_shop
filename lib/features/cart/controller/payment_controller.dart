import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/features/cart/repository/cart_repository.dart';
import 'package:go_shop/features/cart/repository/payment_repository.dart';
import 'package:go_shop/features/cart/view/cart_screen.dart';
import 'package:go_shop/models/order.dart';
import 'package:go_shop/models/payment_status.dart';
import 'package:go_shop/services/dependencies.dart';

final paymentNotifierProvider = StateNotifierProvider((ref) {
  return PaymentNotifier(
    paymentRepository: locator.get<PaymentRepository>(),
    cartRepository: locator.get<CartRepository>(),
  );
});

class PaymentNotifier extends StateNotifier<PaymentStatus> {
  final PaymentRepository paymentRepository;
  final CartRepository cartRepository;
  PaymentNotifier({
    required this.paymentRepository,
    required this.cartRepository,
  }) : super(PaymentInitial());

  Future<void> makePayment(
    BuildContext context,
    WidgetRef ref,
    Order order,
  ) async {
    state = PaymentPending();
    try {
      final result = await paymentRepository.handlePaymentInitialization(
        context,
        ref,
        order,
      );
      final cartItemIDs = ref.read(selectedItemsProvider.notifier).state;
      await Future.wait([
        for (var item in cartItemIDs) cartRepository.removeCartItem(item),
      ]);
      if (result.contains('Payment successful')) {
        state = PaymentSuccess();
        log('success');
      }
    } catch (e) {
      log(StackTrace.current.toString());
      log(e.toString());
      state = PaymentFailed(e.toString());
    }
  }
}
