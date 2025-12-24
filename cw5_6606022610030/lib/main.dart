import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Flutter App')),
      body: Column(
        children: [
          Container(decoration: BoxDecoration(color: Colors.blue), height: 100),
          Container(decoration: BoxDecoration(color: Colors.red), height: 100),
          Container(
            decoration: BoxDecoration(color: Colors.green),
            height: 100,
          ),
        ],
      ),
    );
  }
}
