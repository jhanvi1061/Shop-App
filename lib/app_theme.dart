import 'package:flutter/material.dart';

import './helpers/custom_route.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: const Color(0xff1E4E5F),
    accentColor: const Color(0xffFFB156),
    canvasColor: const Color(0xffFFF7EE),
    fontFamily: "Lato",
    appBarTheme: const AppBarTheme(
      brightness: Brightness.dark,
      backgroundColor: const Color(0xff1E4E5F),
      elevation: 0,
      titleTextStyle: const TextStyle(fontSize: 16),
    ),
    cardTheme: const CardTheme(color: const Color(0xffFFFAF4)),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitinBuilder(),
        TargetPlatform.iOS: CustomPageTransitinBuilder(),
      },
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      elevation: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color(0xff1E4E5F)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: const Color(0xff1E4E5F)),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xff1E4E5F),
      selectionHandleColor: const Color(0xff1E4E5F),
    ),
  );
}
