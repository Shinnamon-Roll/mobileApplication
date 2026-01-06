import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomNumber = random.nextInt(5) + 91;
    return Scaffold(
      appBar: AppBar(title: Text("APP BAR")),
      body: Text(randomNumber.toString(), style: TextStyle(fontSize: 40)),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}
