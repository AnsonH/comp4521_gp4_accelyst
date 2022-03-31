import 'package:flutter/material.dart';

final primaryColor = Colors.indigo[800];
final secondaryColor = Colors.amber[600];

TextTheme proximaNovaTextTheme(BuildContext context, {bool lightTheme = true}) {
  return Theme.of(context).textTheme.apply(
        fontFamily: "ProximaNova",
        fontSizeDelta: 1,
        bodyColor: lightTheme ? Colors.black : Colors.white,
      );
}

final appBarTheme = AppBarTheme(
  backgroundColor: primaryColor,
  titleTextStyle: const TextStyle(
    fontFamily: "ProximaNova",
    fontSize: 21,
    fontWeight: FontWeight.w600,
  ),
);

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    textTheme: proximaNovaTextTheme(context),
    appBarTheme: appBarTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    textTheme: proximaNovaTextTheme(context, lightTheme: false),
    appBarTheme: appBarTheme,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: secondaryColor,
      ),
    ),
  );
}
