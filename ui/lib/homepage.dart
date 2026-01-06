import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

void main() {
  runApp(const MyHomePage());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Elevated'),
                    style: ElevatedButton.styleFrom(fixedSize: Size(300, 80)),
                  ),
                  OutlinedButton(onPressed: onPressed, child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
