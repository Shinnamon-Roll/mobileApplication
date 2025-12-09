import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW2',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Calculator App '),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display Number text
            const Text("Display Number", style: TextStyle(fontSize: 30)),
            
            const SizedBox(height: 10),
            
            // The number display (shows 0)
            const Text("0", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            
            const SizedBox(height: 20),
            
            // Row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: () {}, child: const Text('7')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('8')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('9')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('/')),
              ],
            ),
            const SizedBox(height: 10),
            // Row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: () {}, child: const Text('4')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('5')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('6')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('x')),
              ],
            ),
            const SizedBox(height: 10),
            // Row 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: () {}, child: const Text('1')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('2')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('3')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('-')),
              ],
            ),
            const SizedBox(height: 10),
            // Row 4
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.red[700],
                  child: const Text('C', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('0')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('=')),
                const SizedBox(width: 10),
                FloatingActionButton(onPressed: () {}, child: const Text('+')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}