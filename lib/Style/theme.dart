import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/Constant/constans.dart';

ThemeData darkTheme = ThemeData(
    iconTheme: IconThemeData(color: defaultIconColor),
    iconButtonTheme: IconButtonThemeData(
        style:
        ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(defaultDarkColor),
            iconColor: WidgetStatePropertyAll(defaultIconColor))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(defaultDarkColor),
            textStyle: WidgetStatePropertyAll(TextStyle(color:defaultDarkTextColor)))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            backgroundColor: WidgetStatePropertyAll(defaultDarkColor))),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: defaultDarkColor,
        titleSpacing: 20,
        elevation: 0.0,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor:  Color(0xFF18191a),
        selectedItemColor: Colors.cyan,
        type: BottomNavigationBarType.fixed,
        elevation: 20),
    colorSchemeSeed: Colors.cyan,
    scaffoldBackgroundColor: defaultDarkColor,
    useMaterial3: true,
    textTheme: TextTheme(
        bodySmall: TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: defaultDarkTextColor
        ),
        bodyMedium: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: defaultDarkTextColor),
        bodyLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: defaultDarkTextColor)));
ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(color: defaultIconColor),
    iconButtonTheme: IconButtonThemeData(
        style:
            ButtonStyle(iconColor: WidgetStatePropertyAll(defaultIconColor))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(defaultIconColor),
            textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.black)))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            backgroundColor: WidgetStatePropertyAll(defaultIconColor))),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: defaultColor,
        titleSpacing: 20,
        elevation: 0.0,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF18191a),
        selectedItemColor: Colors.cyan,
        type: BottomNavigationBarType.fixed,
        elevation: 20),
    colorSchemeSeed: Colors.cyan,
    scaffoldBackgroundColor: defaultColor,
    useMaterial3: true,
    textTheme: TextTheme(
      bodySmall: TextStyle(
          fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black
    ),
        bodyMedium: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        bodyLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)));
