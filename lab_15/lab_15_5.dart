import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(PermissionApp());
}

class PermissionApp extends StatelessWidget {
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
  String _status = "Tap the button to request camera permission";

  Future<void> _handleCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() => _status = "✅ Camera permission already granted");
    } else if (status.isDenied) {
      // Request permission
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() => _status = "✅ Camera permission granted after request");
      } else if (result.isDenied) {
        setState(() => _status = "❌ Camera permission denied by user");
      } else if (result.isPermanentlyDenied) {
        _showPermissionDialog();
      }
    } else if (status.isPermanentlyDenied) {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permission Required"),
        content: Text(
            "Camera permission is permanently denied. Please enable it from app settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );

    setState(() => _status = "🚫 Camera permission permanently denied");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Permission Handling")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleCameraPermission,
              child: Text("Request Camera Permission"),
            ),
          ],
        ),
      ),
    );
  }
}
