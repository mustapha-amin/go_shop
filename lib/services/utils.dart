import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_shop/providers/theme_provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get isDark => Provider.of<ThemeProvider>(context).themeStatus;

  Color get color => isDark ? Colors.white : Colors.black;
}
