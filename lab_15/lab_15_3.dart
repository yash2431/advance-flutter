import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationStatus = "Press the button to get location";

  Future<void> _checkLocationPermissionAndGetLocation() async {
    // Step 1: Check if permission is granted
    if (await Permission.location.request().isGranted) {
      // Step 2: Ensure location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationStatus = 'Location services are disabled.';
        });
        return;
      }

      // Step 3: Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationStatus = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } else if (await Permission.location.isPermanentlyDenied) {
      setState(() {
        _locationStatus = 'Location permission permanently denied. Open settings to allow.';
      });
      openAppSettings();
    } else {
      setState(() {
        _locationStatus = 'Location permission denied';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location Permission")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationStatus, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkLocationPermissionAndGetLocation,
              child: Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
