import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // ไฟล์นี้ได้มาจากการรัน flutterfire configure
import 'page1.dart'; // นำเข้าไฟล์ page1.dart ที่เราจะสร้างต่อไป

void main() async {
  // บังคับให้ Flutter bindings ทำงานก่อน เพื่อให้ใช้งาน async/await ใน main ได้
  WidgetsFlutterBinding.ensureInitialized();

  // เริ่มต้นระบบ Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase CRUD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // กำหนดให้หน้าแรกคือ Page1
      home: const Page1(),
    );
  }
}
