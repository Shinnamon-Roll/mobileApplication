import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'form.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Let's Begin"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            fixedSize: const Size(300, 20),
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 15,
            shadowColor: Colors.blue,
            side: const BorderSide(color: Colors.black87, width: 2),
          ),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyForm()),
            );
          },
        ),
      ),
    );
  }
}
