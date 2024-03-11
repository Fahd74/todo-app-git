import 'dart:ui';
import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLD = Color(0xff5D9CEC);
  static Color primaryLight = Color(0xffDFECDB);
  static Color primaryDark = Color(0xff060E1E);
  static Color secondaryDark = Color(0xff141922);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color blackColor = Color(0xff000000);
  static Color greyColor = Color(0xffC8C9CB);
  static Color redColor = Color(0xffEC4B4B);
  static Color greenColor = Color(0xff61E757);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: primaryLight,
    primaryColor: primaryLD,
    secondaryHeaderColor: whiteColor,
    scaffoldBackgroundColor: primaryLight,
    appBarTheme: AppBarTheme(
      toolbarHeight: 130,
      backgroundColor: primaryLD,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLD,
      unselectedItemColor: greyColor,
      showUnselectedLabels: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLD,
      shape: StadiumBorder(
          side: BorderSide(
        color: whiteColor,
        width: 4,
      )),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      titleSmall: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: blackColor),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    backgroundColor: primaryDark,
    primaryColor: primaryLD,
    secondaryHeaderColor: secondaryDark,
    scaffoldBackgroundColor: primaryDark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLD,
      unselectedItemColor: greyColor,
      showUnselectedLabels: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLD,
      shape: StadiumBorder(
          side: BorderSide(
        color: whiteColor,
        width: 4,
      )),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: secondaryDark),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleSmall: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
    ),
  );
}
