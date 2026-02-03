import 'package:flutter/material.dart';
import 'rec.dart';
import 'tri.dart';
import 'cir.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedShape = 'Rectangle'; // Default shape

  // Controllers for text fields
  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final baseController = TextEditingController();
  final radiusController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Function to validate if the input is a valid number
  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null; // No error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geometric Area Calculator')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Radio buttons to select shape
              RadioListTile<String>(
                title: Text('Rectangle'),
                value: 'Rectangle',
                groupValue: selectedShape,
                onChanged: (value) {
                  setState(() {
                    selectedShape = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Triangle'),
                value: 'Triangle',
                groupValue: selectedShape,
                onChanged: (value) {
                  setState(() {
                    selectedShape = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Circle'),
                value: 'Circle',
                groupValue: selectedShape,
                onChanged: (value) {
                  setState(() {
                    selectedShape = value!;
                  });
                },
              ),

              // Form based on selected shape
              if (selectedShape == 'Rectangle') ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Height (h)'),
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  validator: validateNumber,
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Width (w)'),
                  keyboardType: TextInputType.number,
                  controller: widthController,
                  validator: validateNumber,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Rec(
                            height: double.parse(heightController.text),
                            width: double.parse(widthController.text),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Calculate Area'),
                ),
              ],
              if (selectedShape == 'Triangle') ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Base (b)'),
                  keyboardType: TextInputType.number,
                  controller: baseController,
                  validator: validateNumber,
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Height (h)'),
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  validator: validateNumber,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Tri(
                            base: double.parse(baseController.text),
                            height: double.parse(heightController.text),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Calculate Area'),
                ),
              ],
              if (selectedShape == 'Circle') ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Radius (r)'),
                  keyboardType: TextInputType.number,
                  controller: radiusController,
                  validator: validateNumber,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Cir(radius: double.parse(radiusController.text)),
                        ),
                      );
                    }
                  },
                  child: Text('Calculate Area'),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.square_foot), label: 'Area'),
          BottomNavigationBarItem(
            icon: Icon(Icons.aspect_ratio),
            label: 'Volume',
          ),
        ],
      ),
    );
  }
}
