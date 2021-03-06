import 'package:flutter/material.dart';
import 'package:weather_fan/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Fan',
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
