import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData appThemeData() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey[100],
      colorSchemeSeed: Colors.green[700],
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          color:  Colors.black,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey[600],
        ),
        selectedItemColor:   Colors.black,
        unselectedItemColor:  Colors.white,
        elevation: 6,
        backgroundColor:   Colors.white,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[700],
        ),
      ),
    );
  }
}
