import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// API Configuration
const String API_HOST = '10.110.4.44';
const int API_PORT = 5000;

void main() {
  runApp(const ShowInf());
}

class ShowInf extends StatefulWidget {
  const ShowInf({super.key});

  @override
  State<ShowInf> createState() => _ShowInfState();
}

class _ShowInfState extends State<ShowInf> {
  List list = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  Future<String> listData() async {
    var response = await http.get(
      Uri.http('$API_HOST:$API_PORT', 'emp'),
      headers: {"Accept": "application/json"},
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      list = jsonDecode(response.body);
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    listData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DB Test")),
      body: Center(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(child: Text(list[index]['name'])),
                    Expanded(child: Text(list[index]['email'])),
                  ],
                ),
                subtitle: Text(
                  "DOB: ${list[index]['birthdate'] ?? ''}  W: ${list[index]['weight']?.toString() ?? ''}  H: ${list[index]['height']?.toString() ?? ''}",
                ),
                leading: Text(list[index]["id"].toString()),
                trailing: Wrap(
                  spacing: 5,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        Map data = {
                          'id': list[index]['id'],
                          'name': list[index]['name'],
                          'email': list[index]['email'],
                          'phone': list[index]['phone'],
                          'address': list[index]['address'],
                          'birthdate': list[index]['birthdate'],
                          'weight': list[index]['weight']?.toString(),
                          'height': list[index]['height']?.toString(),
                        };
                        _showedit(data);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _showDel(list[index]['id']),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addNewDialog();
        },
      ),
    );
  }

  Future<void> _addNewDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp name",
                    labelText: 'Name:',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp Email",
                    labelText: 'Email:',
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp phone",
                    labelText: 'Phone:',
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp Address",
                    labelText: 'Address:',
                  ),
                ),
                TextField(
                  controller: _birthdateController,
                  decoration: const InputDecoration(
                    hintText: "YYYY-MM-DD",
                    labelText: 'Birthdate:',
                  ),
                ),
                TextField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "e.g., 60.5",
                    labelText: 'Weight (kg):',
                  ),
                ),
                TextField(
                  controller: _heightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "e.g., 170",
                    labelText: 'Height (cm):',
                  ),
                ),
                const Text('กรอกข้อมูลให้เรียบร้อยแล้วกด ยืนยัน'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                add_data();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDel(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ลบข้อมูล $id'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[Text('ยืนยันการลบข้อมูล กด ยืนยัน')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                del_data(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void add_data() async {
    Map data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'birthdate': _birthdateController.text.isNotEmpty
          ? _birthdateController.text
          : null,
      'weight': _weightController.text.isNotEmpty
          ? double.tryParse(_weightController.text)
          : null,
      'height': _heightController.text.isNotEmpty
          ? double.tryParse(_heightController.text)
          : null,
    };
    var body = jsonEncode(data);
    var response = await http.post(
      Uri.http('$API_HOST:$API_PORT', 'create'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _birthdateController.clear();
    _weightController.clear();
    _heightController.clear();
    listData();
  }

  void del_data(int id) async {
    var response = await http.delete(
      Uri.http('$API_HOST:$API_PORT', 'delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    listData();
  }

  Future<void> _showedit(Map data) async {
    _nameController.text = data['name'];
    _emailController.text = data['email'];
    _phoneController.text = data['phone'];
    _addressController.text = data['address'];
    _birthdateController.text = data['birthdate'] ?? '';
    _weightController.text = data['weight']?.toString() ?? '';
    _heightController.text = data['height']?.toString() ?? '';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ทดสอบการ Edit'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp name",
                    labelText: 'Name:',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp Email",
                    labelText: 'Email:',
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp phone",
                    labelText: 'Phone:',
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    hintText: "Enter emp Address",
                    labelText: 'Address:',
                  ),
                ),
                TextField(
                  controller: _birthdateController,
                  decoration: const InputDecoration(
                    hintText: "YYYY-MM-DD",
                    labelText: 'Birthdate:',
                  ),
                ),
                TextField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "e.g., 60.5",
                    labelText: 'Weight (kg):',
                  ),
                ),
                TextField(
                  controller: _heightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "e.g., 170",
                    labelText: 'Height (cm):',
                  ),
                ),
                const Text('ปรับปรุงข้อมูลให้เรียบร้อยแล้วกด ยืนยัน'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                edit_data(data['id']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void edit_data(id) async {
    Map data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'birthdate': _birthdateController.text.isNotEmpty
          ? _birthdateController.text
          : null,
      'weight': _weightController.text.isNotEmpty
          ? double.tryParse(_weightController.text)
          : null,
      'height': _heightController.text.isNotEmpty
          ? double.tryParse(_heightController.text)
          : null,
    };
    var body = jsonEncode(data);
    var response = await http.put(
      Uri.http('$API_HOST:$API_PORT', 'update/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    listData();
  }
}
