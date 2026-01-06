import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: String.fromCharCode(0x1F600) + ' My Flutter App',
      home: const MyHomePage(),
      theme: ThemeData(colorScheme: ColorScheme.dark()),
    );
  }
}
