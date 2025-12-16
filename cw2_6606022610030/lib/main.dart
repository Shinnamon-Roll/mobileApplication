import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'CW2', home: const MyHomePage());
  }
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
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "7";
                        ShowVal = num1;
                      } else {
                        num2 += "7";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('7'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "8";
                        ShowVal = num1;
                      } else {
                        num2 += "8";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('8'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "9";
                        ShowVal = num1;
                      } else {
                        num2 += "9";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('9'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      Operator = "/";
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "4";
                        ShowVal = num1;
                      } else {
                        num2 += "4";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('4'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "5";
                        ShowVal = num1;
                      } else {
                        num2 += "5";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('5'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "6";
                        ShowVal = num1;
                      } else {
                        num2 += "6";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('6'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      Operator = "x";
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "1";
                        ShowVal = num1;
                      } else {
                        num2 += "1";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('1'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "2";
                        ShowVal = num1;
                      } else {
                        num2 += "2";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('2'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "3";
                        ShowVal = num1;
                      } else {
                        num2 += "3";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('3'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      Operator = "-";
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      num1 = "";
                      num2 = "";
                      Operator = "";
                      ShowVal = "";
                      Result = "";
                    });
                  },
                  backgroundColor: Colors.red[700],
                  child: const Text('C', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (Operator.isEmpty) {
                        num1 += "0";
                        ShowVal = num1;
                      } else {
                        num2 += "0";
                        ShowVal = num2;
                      }
                    });
                  },
                  child: const Text('0'),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      double n1 = double.parse(num1);
                      double n2 = double.parse(num2);
                      double calc = 0;
                      if (Operator == "+") {
                        calc = n1 + n2;
                      } else if (Operator == "-") {
                        calc = n1 - n2;
                      } else if (Operator == "x") {
                        calc = n1 * n2;
                      } else if (Operator == "/") {
                        calc = n1 / n2;
                      } else if (Operator == "%") {
                        calc = (n1 / 100) * n2;
                      } else if (Operator == "^") {
                        calc = pow(n1, n2).toDouble();
                      }
                      Result = calc.toString();
                      ShowVal = Result;
                      num1 = Result;
                      num2 = "";
                      Operator = "";
                    });
                  },
                  child: const Text('='),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      Operator = "+";
                    });
                  },
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
                  onPressed: () {
                    setState(() {
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
                  },
                  child: const Text(
                    'DEL',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.orange[700],
                  onPressed: () {
                    setState(() {
                      Operator = "%";
                    });
                  },
                  child: const Text('%', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.orange[700],
                  onPressed: () {
                    setState(() {
                      Operator = "^";
                    });
                  },
                  child: const Text('^', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.orange[700],
                  onPressed: () {
                    setState(() {
                      if (num1.isNotEmpty && Operator.isEmpty) {
                        double n1 = double.parse(num1);
                        double sqrtResult = sqrt(n1);
                        Result = sqrtResult.toString();
                        ShowVal = Result;
                        num1 = Result;
                      }
                    });
                  },
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
