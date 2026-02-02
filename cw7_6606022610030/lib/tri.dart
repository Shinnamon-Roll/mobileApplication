import 'package:flutter/material.dart';

class Tri extends StatelessWidget {
  final double base;
  final double height;

  Tri({required this.base, required this.height});

  @override
  Widget build(BuildContext context) {
    double area = 0.5 * base * height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Triangle Area'),
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
            Text('Base: $base'),
            Text('Height: $height'),
            SizedBox(height: 20),
            Text(
              'Area: $area',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
