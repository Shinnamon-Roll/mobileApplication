import 'package:flutter/material.dart';
import 'foodMenu.dart'; 

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
    FoodMenu("กุ้งเผา", "500", "assets/images/กุ้งเผา.avif", "เผา"),
    FoodMenu("กระเพราหมูสับ", "80", "assets/images/กระเพราหมูสับ.avif", "ผัด"),
    FoodMenu("ข้าวผัดกุ้ง", "90", "assets/images/ข้าวผัดกุ้ง.webp", "ผัด"),
    FoodMenu("ก๋วยเตี๋ยวต้มยำ", "60", "assets/images/ก๋วยเตี๋ยวต้มยำ.jpg", "ต้ม"),
    FoodMenu("ไก่ย่าง", "150", "assets/images/ไก่ย่าง.webp", "ย่าง"),
    FoodMenu("หมูทอดกระเทียม", "85", "assets/images/หมูทอดกระเทียม.avif", "ทอด"),
    FoodMenu("ปลานึ่งมะนาว", "180", "assets/images/ปลานึ่งมะนาว.jpg", "นึ่ง"),
    FoodMenu("ต้มยำกุ้ง", "200", "assets/images/ต้มยำกุ้ง.webp", "ต้ม"),
    FoodMenu("ส้มตำไทย", "50", "assets/images/ส้มตำไทย.webp", "ยำ"),
    FoodMenu("ลาบหมู", "70", "assets/images/ลาบหมู.jpg", "ยำ"),
    FoodMenu("แกงเขียวหวานไก่", "75", "assets/images/แกงเขียวหวานไก่.jpg", "แกง"),
    FoodMenu("ผัดไทยกุ้งสด", "100", "assets/images/ผัดไทยกุ้งสด.jpg", "ผัด"),
    FoodMenu("ปลาเผาเกลือ", "250", "assets/images/ปลาเผาเกลือ.jpg", "เผา"),
    FoodMenu("ไข่เจียวหมูสับ", "55", "assets/images/ไข่เจียวหมูสับ.jpg", "ทอด"),
    FoodMenu("ขาหมูนึ่ง", "120", "assets/images/ขาหมูนึ่ง.jpg", "นึ่ง"),
    FoodMenu("หมูย่างน้ำตก", "110", "assets/images/หมูย่างน้ำตก.jpg", "ย่าง"),
    FoodMenu("แกงส้มผักรวม", "65", "assets/images/แกงส้มผักรวม.jpg", "แกง"),
    FoodMenu("ยำวุ้นเส้น", "80", "assets/images/ยำวุ้นเส้น.jpg", "ยำ"),
    FoodMenu("ต้มข่าไก่", "85", "assets/images/ต้มข่าไก่.jpg", "ต้ม"),
    FoodMenu("ปลาทอดน้ำปลา", "140", "assets/images/ลาทอดน้ำปลา.jpg", "ทอด"),
  ];

  String lastSelectedMenu = ""; 

  void _selectMenu(int index) {
    setState(() {
      menu[index].isSelected = !menu[index].isSelected;
      if (menu[index].isSelected) {
        lastSelectedMenu = menu[index].name;
      }
    });

    int totalDishes = menu.where((item) => item.isSelected).length;
    int totalPrice = menu
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + int.parse(item.price));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("สรุปการเลือก"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "เมนูที่เลือกล่าสุด: $lastSelectedMenu",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("จำนวนที่เลือก: $totalDishes จาน"),
              Text("ราคารวม: $totalPrice บาท"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ตกลง"),
            ),
          ],
        );
      },
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "ต้ม":
        return Colors.blue;
      case "ย่าง":
        return Colors.orange;
      case "ทอด":
        return Colors.amber;
      case "นึ่ง":
        return Colors.green;
      case "เผา":
        return Colors.red;
      case "ผัด":
        return Colors.purple;
      case "ยำ":
        return Colors.pink;
      case "แกง":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

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
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: food.isSelected ? Colors.blue[50] : null,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      food.img,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: Icon(Icons.restaurant, color: Colors.grey[600]),
                        );
                      },
                    ),
                  ),
                  if (food.isSelected)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 16),
                      ),
                    ),
                ],
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      food.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getTypeColor(food.type),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      food.type,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  "ราคา ${food.price} บาท",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              trailing: Icon(
                food.isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: food.isSelected ? Colors.green : Colors.blue[400],
                size: 24,
              ),
              onTap: () => _selectMenu(index),
            ),
          );
        },
      ),
    );
  }
}
