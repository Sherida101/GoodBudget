import 'package:flutter/material.dart';

var lightThemeData = ThemeData(
    // primaryColor: Colors.teal,
    primarySwatch: Colors.teal,
    textTheme: const TextTheme(button: TextStyle(color: Colors.white70)),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber));

var darkThemeData = ThemeData(
    // primaryColor: Colors.black,
    primarySwatch: Colors.teal,
    textTheme: const TextTheme(button: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber));
