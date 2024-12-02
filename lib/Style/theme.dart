import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/Constant/constans.dart';
ThemeData darkTheme=ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleSpacing: 20,
        elevation: 0.0,
        titleTextStyle:
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF18191a),
        selectedItemColor: Colors.cyan,
        type: BottomNavigationBarType.fixed, elevation: 20),
    colorSchemeSeed: Colors.cyan,
    scaffoldBackgroundColor:Colors.black,
    useMaterial3: true,
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight:FontWeight.w600,
            color: Colors.black
        )
    )
);
ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,

      ),
        backgroundColor: defaultColor,
        titleSpacing: 20,
        elevation: 0.0,
        titleTextStyle:
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF18191a),
        selectedItemColor: Colors.cyan,
        type: BottomNavigationBarType.fixed, elevation: 20),
    colorSchemeSeed: Colors.cyan,
    scaffoldBackgroundColor:defaultColor,
    useMaterial3: true,
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight:FontWeight.w600,
            color: Colors.black
        )
    )
);

