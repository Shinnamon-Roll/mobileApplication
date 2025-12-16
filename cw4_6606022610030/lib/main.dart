import 'package:flutter/material.dart';
import 'foodMenu.dart'; // นำเข้าไฟล์ Class ที่สร้างไว้ [cite: 581]

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Menu App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FoodMenu> menu = [
    FoodMenu("กุ้งเผา", "500"),
    FoodMenu("กระเพราหมู", "80"),
    FoodMenu("ข้าวผัด", "60"),
    FoodMenu("ก๋วยเตี๋ยว", "50"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เลือกเมนูอาหาร"),
        backgroundColor: Colors.blue[700],
        elevation: 4,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          FoodMenu food = menu[index];
          return ListTile(
            contentPadding: EdgeInsets.only(left: 16, right: 16),
            leading: CircleAvatar(
              backgroundColor: Colors.blue[400],
              child: Text(
                '${index + 1}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              "เมนูที่ ${index + 1}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${food.name} ราคา ${food.price} บาท"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue[400],
              size: 16,
            ),
            horizontalTitleGap: 12,
          );
        },
      ),
    );
  }
}
