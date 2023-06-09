import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData themeData(BuildContext context, bool isDark) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      colorSchemeSeed: Colors.green[700],
      listTileTheme: ListTileThemeData(
        textColor: isDark ? Colors.white : Colors.black,
        iconColor: isDark ? Colors.white : Colors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        unselectedIconTheme: IconThemeData(
          color: isDark ? Colors.grey[200] : Colors.grey[600],
        ),
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: isDark ? Colors.black : Colors.white,
        elevation: 6,
        backgroundColor: isDark ? Colors.black12 : Colors.white,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        color: isDark ? Colors.grey : Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[700],
        ),
      ),
    );
  }
}
