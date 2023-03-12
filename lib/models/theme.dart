import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {

  final ThemeData currentTheme; 
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.blue,
    primaryColorLight: Colors.blueAccent,
    primaryColorDark: Colors.blueAccent.shade700,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,

    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade600,
      shape: const CircleBorder(side: BorderSide.none),
      enableFeedback: true,
      focusElevation: 20.0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: const Color.fromARGB(255, 6, 35, 39),
    primaryColorLight: Colors.grey.shade800,
    primaryColorDark: const Color.fromARGB(255, 16, 22, 26),
    scaffoldBackgroundColor: const Color.fromARGB(255, 36, 35, 40),
    bottomAppBarColor: const Color.fromARGB(255, 41, 43, 43),
    disabledColor: Colors.black,
    cardColor: const Color.fromARGB(255, 5, 29, 70),
    shadowColor: Colors.blueGrey.shade900,
    iconTheme: const IconThemeData(
      color: Colors.white60,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: const Color.fromARGB(255, 14, 29, 40),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.blueGrey.shade900,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.black
      ),
      titleTextStyle: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w500,
        color: Colors.blueGrey.shade50
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 12, 21, 25),
        foregroundColor: Colors.white70,
        disabledBackgroundColor: Colors.blueGrey.shade900,
        disabledForegroundColor: Colors.white24
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(side: BorderSide.none),
      enableFeedback: true,
      focusElevation: 20.0,
      backgroundColor: Color.fromARGB(255, 14, 37, 47)
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: Colors.blueGrey.shade600,
      selectedTileColor: Colors.blueGrey
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 30, 40, 36),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        foregroundColor: Colors.white,
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white70,
        disabledForegroundColor: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide.none)
      )
    )
  );

  CustomTheme(this.currentTheme);
}