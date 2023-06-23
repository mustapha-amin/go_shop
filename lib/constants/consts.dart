import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

kTextStyle(
        {double? size, isBold = false, Color? color}) =>
    GoogleFonts.lato(
        fontSize: size!.sp,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black);

String nairaSymbol = '₦';

RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$');

RegExp passwordRegex = RegExp(
    r'''^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+[{\]};:\'",<.>/?\\|`~])[^\s]{8,}$''');
