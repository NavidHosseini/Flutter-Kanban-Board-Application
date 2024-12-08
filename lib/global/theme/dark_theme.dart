import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  primaryColor: Colors.grey.withOpacity(0.1),
  cardColor: Colors.white.withOpacity(0.5),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
);
