import 'package:flutter/material.dart';
import 'dart:ui';
import 'Shopping.dart';

class MyForm extends StatefulWidget {
  const MyForm({key? key}) : super(key: key);
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
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }
}
