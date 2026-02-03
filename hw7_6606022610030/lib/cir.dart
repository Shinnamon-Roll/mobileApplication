import 'package:flutter/material.dart';
import 'dart:math' as math;

class Cir extends StatelessWidget {
  final double radius;

  Cir({required this.radius});

  @override
  Widget build(BuildContext context) {
    double area = math.pi * radius * radius;

    return Scaffold(
      appBar: AppBar(
        title: Text('Circle Area'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Radius: $radius'),
            SizedBox(height: 20),
            Text(
              'Area: ${area.toStringAsFixed(4)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
