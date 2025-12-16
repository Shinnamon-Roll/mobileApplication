import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'CW2', home: const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int num = 0;
  String num1 = "";
  String num2 = "";
  String Operator = "";
  String ShowVal = "";
  String Result = "";

  // Helper methods converted from inline closures (use arrow-call style)
  void pressNumber(String d) => setState(() {
    if (Operator.isEmpty) {
      num1 += d;
      ShowVal = num1;
    } else {
      num2 += d;
      ShowVal = num2;
    }
  });

  void pressOperator(String op) => setState(() {
    Operator = op;
  });

  void pressClear() => setState(() {
    num1 = "";
    num2 = "";
    Operator = "";
    ShowVal = "";
    Result = "";
  });

  void pressDel() => setState(() {
    if (Operator.isEmpty) {
      if (num1.isNotEmpty) {
        num1 = num1.substring(0, num1.length - 1);
        ShowVal = num1;
      }
    } else {
      if (num2.isNotEmpty) {
        num2 = num2.substring(0, num2.length - 1);
        ShowVal = num2;
      }
    }
  });

  void pressEqual() => setState(() {
    double n1 = double.parse(num1.isEmpty ? "0" : num1);
    double n2 = double.parse(num2.isEmpty ? "0" : num2);
    double calc = 0;
    switch (Operator) {
      case "+":
        calc = n1 + n2;
        break;
      case "-":
        calc = n1 - n2;
        break;
      case "x":
        calc = n1 * n2;
        break;
      case "/":
        calc = n1 / n2;
        break;
      case "%":
        calc = (n1 / 100) * n2;
        break;
      case "^":
        calc = pow(n1, n2).toDouble();
        break;
      default:
        calc = n1;
    }
    Result = calc.toString();
    ShowVal = Result;
    num1 = Result;
    num2 = "";
    Operator = "";
  });

  void pressSqrt() => setState(() {
    if (num1.isNotEmpty && Operator.isEmpty) {
      double n1 = double.parse(num1);
      double sqrtResult = sqrt(n1);
      Result = sqrtResult.toString();
      ShowVal = Result;
      num1 = Result;
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Calculator App ')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display Number text
            Text(ShowVal, style: TextStyle(fontSize: 30)),

            const SizedBox(height: 20),

            // Row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => pressNumber("7"),
                  child: const Text('7'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressNumber("8"),
                  child: const Text('8'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressNumber("9"),
                  child: const Text('9'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressOperator("/"),
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => pressNumber("4"),
                  child: const Text('4'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressNumber("5"),
                  child: const Text('5'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressNumber("6"),
                  child: const Text('6'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressOperator("x"),
                  child: const Text('x'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Row 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => pressNumber("1"),
                  child: const Text('1'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressNumber("2"),
                  child: const Text('2'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressNumber("3"),
                  child: const Text('3'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressOperator("-"),
                  child: const Text('-'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Row 4
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => pressClear(),
                  backgroundColor: Colors.red[700],
                  child: const Text('C', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressNumber("0"),
                  child: const Text('0'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressEqual(),
                  child: const Text('='),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => pressOperator("+"),
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Row 5 - New buttons (DEL, %, ^, √)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.orange[700],
                  onPressed: () => pressDel(),
                  child: const Text(
                    'DEL',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.orange[700],
                  onPressed: () => setState(() {
                    Operator = "%";
                  }),
                  child: const Text('%', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.orange[700],
                  onPressed: () => setState(() {
                    Operator = "^";
                  }),
                  child: const Text('^', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.orange[700],
                  onPressed: () => setState(() {
                    if (num1.isNotEmpty && Operator.isEmpty) {
                      double n1 = double.parse(num1);
                      double sqrtResult = sqrt(n1);
                      Result = sqrtResult.toString();
                      ShowVal = Result;
                      num1 = Result;
                    }
                  }),
                  child: const Text('√', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
