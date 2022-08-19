import 'package:flutter/material.dart';

class Font {
  static const inter = "inter";
}

class AppTheme {
  static ThemeData get lTheme => ThemeData(
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       primary: const Color(0xffFFD9C0),
      //     ).merge(
      //       ButtonStyle(elevation: MaterialStateProperty.all(0)),
      //     )),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,

      ),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff5FD068)),
      primaryColor: const Color(0xff5FD068),
      fontFamily: Font.inter,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff5FD068)));

  static ThemeData get dTheme => ThemeData(
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       primary: const Color(0xffFFD9C0),
      //     ).merge(
      //       ButtonStyle(elevation: MaterialStateProperty.all(0)),
      //     )),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),

      primaryColor: const Color(0xff5FD068),
      fontFamily: Font.inter,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black87,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff5FD068)));

// you can add other custom theme in this class like  light theme, dark theme ,etc.

// example :
// static ThemeData get light => ThemeData();

// static ThemeData get dark => ThemeData();
}
