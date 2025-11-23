import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(CameraPermissionApp());
}

class CameraPermissionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraPermissionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CameraPermissionScreen extends StatefulWidget {
  @override
  _CameraPermissionScreenState createState() => _CameraPermissionScreenState();
}

class _CameraPermissionScreenState extends State<CameraPermissionScreen> {
  String _permissionStatus = "Unknown";

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() => _permissionStatus = "Camera permission granted");
    } else if (status.isDenied) {
      final result = await Permission.camera.request();

      if (result.isGranted) {
        setState(() => _permissionStatus = "Camera permission granted after request");
      } else {
        setState(() => _permissionStatus = "Camera permission denied");
      }
    } else if (status.isPermanentlyDenied) {
      setState(() => _permissionStatus = "Permission permanently denied. Please enable from settings.");
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Permission")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_permissionStatus, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkCameraPermission,
              child: Text("Request Camera Permission"),
            ),
          ],
        ),
      ),
    );
  }
}
