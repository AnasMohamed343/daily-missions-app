import 'package:flutter/material.dart';

class MyThemeData {
  static const Color lightPrimaryColor = Color(0xff5D9CEC);
  static const Color darkPrimaryColor = Color(0xff060E1E);
  static const Color darkSecondaryColor = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    splashColor: Color(0xFFDFECDB),
    appBarTheme: AppBarTheme(
      color: lightPrimaryColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: Color(0xFFDFECDB),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 23,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
          fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
        fontSize: 19,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        decoration: TextDecoration.underline,
        decorationColor: Colors.black,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: lightPrimaryColor,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: lightPrimaryColor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(
        size: 30,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    cardColor: Colors.white,
    dividerColor: lightPrimaryColor,
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    splashColor: darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: lightPrimaryColor,
      titleTextStyle: TextStyle(
        color: darkPrimaryColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: darkPrimaryColor,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: darkPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 23,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
          fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
        fontSize: 19,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: Colors.white,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: darkSecondaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkSecondaryColor,
      selectedItemColor: lightPrimaryColor,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(
        size: 30,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape:
          StadiumBorder(side: BorderSide(color: darkSecondaryColor, width: 4)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkSecondaryColor,
    ),
    cardColor: darkSecondaryColor,
    dividerColor: Colors.white,
  );
}
