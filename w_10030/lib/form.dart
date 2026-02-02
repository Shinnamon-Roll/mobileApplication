import 'package:flutter/material.dart';
import 'display.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _controller = TextEditingController();
  String? errorText;

  void checkNumber() {
    if (_controller.text.isEmpty) {
      setState(() {
        errorText = 'กรุณากรอกตัวเลข';
      });
      return;
    }

    final int? number = int.tryParse(_controller.text);

    if (number == null) {
      setState(() {
        errorText = 'กรุณากรอกเป็นตัวเลขเท่านั้น';
      });
      return;
    }

    // ไปหน้า display.dart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(number: number),
      ), // MaterialPageRoute
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Page')), // AppBar
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'กรอกตัวเลข',
                errorText: errorText,
              ), // InputDecoration
            ), // TextField
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkNumber,
              child: const Text('Check Number'),
            ), // ElevatedButton
          ],
        ), // Column
      ), // Padding
    ); // Scaffold
  }
}
