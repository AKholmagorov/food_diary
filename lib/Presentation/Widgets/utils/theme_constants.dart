import 'package:flutter/material.dart';

ThemeData foodDiaryDarkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w500
    )
  ),

  sliderTheme: SliderThemeData(
    thumbColor: Colors.black,
    activeTrackColor: Colors.black,
    inactiveTrackColor: Color(0xFFD9D9D9),
    overlayColor: Colors.black.withOpacity(0.1),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.black
  ),

  expansionTileTheme: ExpansionTileThemeData(
    textColor: Colors.black,
    backgroundColor: Color(0xFFF7F7F7F7),
    collapsedBackgroundColor: Color(0xFFF7F7F7F7),
    expandedAlignment: Alignment.centerLeft,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: 0.3),
      borderRadius: BorderRadius.all(Radius.circular(10))),
    collapsedShape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: 0.3),
      borderRadius: BorderRadius.all(Radius.circular(10))),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: Color(0xFF818181)
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.black,
        width: 0.8,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
          color: Colors.black,
          width: 0.5
      ),
    ),
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w500),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withAlpha(80)
  ),
);