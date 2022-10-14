import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData themeData(BuildContext context, bool isDark) {
    return ThemeData(
      scaffoldBackgroundColor: isDark ? Colors.grey[900] : Colors.white,
      primaryColor: Colors.green,
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
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
