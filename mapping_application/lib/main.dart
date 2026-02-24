import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map App',
      theme: ThemeData(useMaterial3: false, primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// ==========================================
// 1. หน้าแรก (Home Page)
// ==========================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map New'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapSample()),
                );
              },
              child: const Text('Simple Map'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CurrentLocationPage(),
                  ),
                );
              },
              child: const Text('Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. หน้า Simple Map
// ==========================================
class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(14.1585968, 101.3457501),
    zoom: 14.0,
  );

  static const CameraPosition _targetPosition = CameraPosition(
    target: LatLng(14.05225861133584, 101.3714520594751),
    tilt: 45.0,
    zoom: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TEST MAP')),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToNewLocation,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToNewLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_targetPosition),
    );
  }
}

// ==========================================
// 3. หน้า Current Location (แบบกำหนดพิกัดตายตัว)
// ==========================================
class CurrentLocationPage extends StatefulWidget {
  const CurrentLocationPage({super.key});

  @override
  State<CurrentLocationPage> createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(14.1585968, 101.3457501),
    zoom: 14.0,
  );

  // ฟังก์ชันเคลื่อนที่ไปพิกัดที่กำหนด พร้อมปักหมุด
  Future<void> _goToSpecificLocation() async {
    // กำหนดพิกัดใหม่ตามที่คุณต้องการ
    const LatLng targetLatLng = LatLng(14.147806470512888, 101.36606512668914);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(target: targetLatLng, zoom: 18.0),
      ),
    );

    setState(() {
      _markers.clear();
      _markers.add(
        const Marker(
          markerId: MarkerId('current_location'),
          position: targetLatLng,
          infoWindow: InfoWindow(title: 'You are here!'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Current Location')),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToSpecificLocation, // เรียกใช้ฟังก์ชันที่แก้ใหม่
        label: const Text('Current Location'),
        icon: const Icon(Icons.account_circle),
      ),
    );
  }
}
