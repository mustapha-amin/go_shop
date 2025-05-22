import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

void displayFlushBar(
  BuildContext context,
  String? message, {
  bool isError = false,
}) {
  Flushbar(
    message: message,
    icon: Icon(
      isError ? Iconsax.tick_circle : Iconsax.danger,
      size: 28.0,
      color: isError ? Colors.red : Colors.green,
    ),
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}
