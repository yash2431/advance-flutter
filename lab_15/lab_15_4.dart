import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MultiPermissionApp());
}

class MultiPermissionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiPermissionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MultiPermissionScreen extends StatefulWidget {
  @override
  _MultiPermissionScreenState createState() => _MultiPermissionScreenState();
}

class _MultiPermissionScreenState extends State<MultiPermissionScreen> {
  String _status = "Press the button to check permissions";

  Future<void> _requestMultiplePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
    ].request();

    String result = "";

    statuses.forEach((permission, status) {
      result += "${permission.toString().split('.').last}: ${status.name}\n";
    });

    setState(() {
      _status = result;
    });

    // Optional: Handle permanently denied case
    if (statuses.values.any((status) => status.isPermanentlyDenied)) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multiple Permissions")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestMultiplePermissions,
              child: Text("Request Permissions"),
            ),
          ],
        ),
      ),
    );
  }
}
