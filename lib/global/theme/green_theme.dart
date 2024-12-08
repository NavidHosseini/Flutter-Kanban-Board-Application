import 'package:flutter/material.dart';

final ThemeData greenTheme = ThemeData(
  primarySwatch: Colors.green,
  primaryColor: Colors.green.withOpacity(0.1),
  brightness: Brightness.light,
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 91, 168, 94),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.green,
    textTheme: ButtonTextTheme.primary,
  ),
);
