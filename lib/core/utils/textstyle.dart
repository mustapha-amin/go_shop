import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kTextStyle(
  double size, {
  FontWeight fontweight = FontWeight.normal,
  Color color = Colors.black,
}) {
  return GoogleFonts.gabarito(
    fontSize: size,
    fontWeight: fontweight,
    color: color,
  );
}
