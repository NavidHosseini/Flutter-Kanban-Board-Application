import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  primaryColor: Colors.grey.withOpacity(0.1),
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 61, 150, 223),
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
