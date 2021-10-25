import 'package:flutter/material.dart';

abstract class ThemeText {
  static const tempTextStyle = TextStyle(
    fontFamily: 'Spartan',
    fontSize: 100.0,
  );

  static const messageTextStyle = TextStyle(
    fontFamily: 'Spartan',
    fontSize: 50.0,
  );

  static const buttonTextStyle = TextStyle(
    fontSize: 30.0,
    color: Colors.white,
    fontFamily: 'Spartan',
  );

  static const conditionTextStyle = TextStyle(
    fontSize: 100.0,
  );

  static InputDecoration textFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: const Icon(Icons.location_city, color: Colors.white),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: 'Enter a City Name',
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
  );
}
