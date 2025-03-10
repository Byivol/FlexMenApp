import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.blue.withOpacity(0.3),
    selectionHandleColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
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
      color: Colors.white,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      fontSize: 26,
    ),
    bodyLarge: TextStyle(color: Colors.white),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.w500),
      overlayColor: Colors.transparent,
    ),
  ),
  iconTheme: IconThemeData(color: Colors.black),
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
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
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
