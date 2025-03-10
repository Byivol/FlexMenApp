import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue.withOpacity(0.3),
    selectionHandleColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(16),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      fontSize: 26,
    ),
    bodyLarge: TextStyle(color: Colors.black),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: TextStyle(fontWeight: FontWeight.w500),
      overlayColor: Colors.transparent,
    ),
  ),
  iconTheme: IconThemeData(size: 22, color: Colors.black),
  expansionTileTheme: ExpansionTileThemeData(
    collapsedTextColor: Colors.black,
    textColor: Colors.black,
    shape: const Border(
      top: BorderSide.none,
      bottom: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 0),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      iconColor: Colors.black,
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ).copyWith(iconSize: WidgetStateProperty.all(22.0)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.black,
    selectedIconTheme: IconThemeData(size: 20, color: Colors.white),
    selectedItemColor: Colors.white,
    selectedLabelStyle: TextStyle(fontSize: 10, color: Colors.white),
    unselectedIconTheme: IconThemeData(size: 20, color: Colors.grey),
    unselectedItemColor: Colors.grey,
    unselectedLabelStyle: TextStyle(fontSize: 10, color: Colors.grey),
  ),
);
