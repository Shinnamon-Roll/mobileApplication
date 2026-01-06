import 'package:flutter/material.dart';
import 'shopping.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var _productName = '';
  var _customerName = '';

  final _productController = TextEditingController();
  final _customerController = TextEditingController();

  void initState() {
    super.initState();
    _productController.addListener(_updateText);
    _customerController.addListener(_updateText);
  }

  void _updateText() {
    setState(() {
      _productName = _productController.text;
      _customerName = _customerController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form')),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _productController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.verified_user_outlined),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _customerController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                prefixIcon: Icon(Icons.verified_user_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            myBtn(context),
            const SizedBox(height: 20),
            Text(
              'Product Name is : ${_productController.text}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Customer Name is : ${_customerController.text}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget myBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const forShopping()),
        );
      },
      child: const Text('Go to Shopping 🛒'),
    );
  }
}
