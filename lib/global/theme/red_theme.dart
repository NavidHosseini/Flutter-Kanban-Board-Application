import 'package:flutter/material.dart';

final ThemeData redTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.red.withOpacity(0.1),
  brightness: Brightness.light,
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 240, 82, 71),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.red,
    textTheme: ButtonTextTheme.primary,
  ),
);
