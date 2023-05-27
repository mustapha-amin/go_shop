import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

kTextStyle(double? size, BuildContext context, [isBold = false]) => GoogleFonts.lato(
  fontSize: size,
  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
);
