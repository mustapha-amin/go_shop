import 'package:flutter/material.dart';
import 'package:go_shop/services/utils.dart';
import 'package:google_fonts/google_fonts.dart';

kTextStyle(double? size, BuildContext context, [isBold = false]) => GoogleFonts.lato(
  fontSize: size,
  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  color: Utils(context).color,
);

RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$');

RegExp passwordRegex = RegExp(r'''^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+[{\]};:\'",<.>/?\\|`~])[^\s]{8,}$''');
