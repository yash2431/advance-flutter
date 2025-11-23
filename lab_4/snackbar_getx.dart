// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Use GetMaterialApp instead of MaterialApp
      title: 'GetX SnackBar Example',
      home: SnackBarExampleScreen(),
    );
  }
}

class SnackBarExampleScreen extends StatelessWidget {
  void showMySnackBar() {
    Get.snackbar(
      'Success',                // Title
      'Button clicked!',        // Message
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX SnackBar Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showMySnackBar,
          child: Text('Show SnackBar'),
        ),
      ),
    );
  }
}
