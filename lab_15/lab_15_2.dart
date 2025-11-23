import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(StoragePermissionApp());
}

class StoragePermissionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoragePermissionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StoragePermissionScreen extends StatefulWidget {
  @override
  _StoragePermissionScreenState createState() => _StoragePermissionScreenState();
}

class _StoragePermissionScreenState extends State<StoragePermissionScreen> {
  String _permissionStatus = "Unknown";

  Future<void> _checkStoragePermission() async {
    final status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      setState(() => _permissionStatus = "Storage permission granted");
    } else if (status.isDenied) {
      final result = await Permission.storage.request();

      if (result.isGranted) {
        setState(() => _permissionStatus = "Permission granted after request");
      } else {
        setState(() => _permissionStatus = "Permission denied");
      }
    } else if (status.isPermanentlyDenied) {
      setState(() => _permissionStatus = "Permission permanently denied. Open settings to allow.");
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Storage Permission")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_permissionStatus, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkStoragePermission,
              child: Text("Request Storage Permission"),
            ),
          ],
        ),
      ),
    );
  }
}
