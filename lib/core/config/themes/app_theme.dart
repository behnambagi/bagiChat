import 'package:bagi_chat/core/fonts/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
 static CupertinoThemeData get themeLight =>const CupertinoThemeData(
   textTheme: CupertinoTextThemeData(
       textStyle: TextStyle(fontFamily: Fonts.outfit)
   ),
   brightness: Brightness.light,
   primaryColor: Color(0xff08C187),
 );

 static TextStyle get titleStyle => TextStyle(
     color: const Color(0xFF08C187).
     withOpacity(0.7), fontSize: 17);

 static TextStyle get inputTextStyle => TextStyle(
     color: CupertinoColors.systemGrey.withOpacity(0.7),
     fontSize: 17);

}