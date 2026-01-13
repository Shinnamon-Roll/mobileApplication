import 'package:flutter/material.dart';
import 'dart:ui';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var _productName;
  var _productPrice;

  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();

  bool? _checkBox, _listTileCheckBox = false;

  @override
  void initState() {
    super.initState();
    _checkBox = false;
    _listTileCheckBox = false;
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  void _updateTextField() {
    setState(() {
      _productName = _productNameController.text;
      _productPrice = _productPriceController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PRODUCT")), // AppBar
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text("PRODUCT App", style: TextStyle(fontSize: 30)), // Text
            const Text("Add Product detail in the form "),
            SizedBox(height: 10.0),
            MyTextField(
              fieldName: "Product Name",
              myController: _productNameController,
              myIcon: Icons.pin_drop_sharp,
              prefixIconColor: Colors.deepPurple.shade300,
            ), // MyTextField
            SizedBox(height: 20.0),
            MyTextField(
              fieldName: "Product Description",
              myController: _productPriceController,
              myIcon: Icons.pin_drop_sharp,
              prefixIconColor: Colors.deepPurple.shade300,
            ), // MyTextField
            SizedBox(height: 20.0),
            // Two Types of Check Box

            //1. check box
            Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.deepPurple,
              tristate: true,
              value: _checkBox,
              onChanged: (val) {
                setState(() {
                  _checkBox = val;
                });
              },
            ), // Checkbox
            //2. check box list tile
            CheckboxListTile(
              value: _listTileCheckBox,
              title: Text("Top Product"),
              onChanged: (val) {
                setState(() {
                  _listTileCheckBox = val;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ), // CheckboxListTile

            SizedBox(height: 20.0),
            myBtn(context),
            SizedBox(height: 40.0),
          ],
        ), // ListView
      ), // Container
    ); // Scaffold
  }

  Center myBtn(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _updateTextField();
        },
        child: const Text("Add Product"),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(myIcon, color: prefixIconColor), // Icon
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade300),
        ), // OutlineInputBorder
        labelStyle: const TextStyle(color: Colors.deepPurple),
      ), // InputDecoration
    ); // TextFormField
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MyForm(),
    );
  }
}
