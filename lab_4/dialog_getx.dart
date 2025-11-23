// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp instead of MaterialApp
      title: 'GetX Dialog Example',
      home: DialogExampleScreen(),
    );
  }
}

class DialogExampleScreen extends StatelessWidget {
  void showMyDialog() {
    Get.defaultDialog(
      title: 'Alert',
      middleText: 'Are you sure you want to continue?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // Close dialog
        Get.snackbar('Confirmed', 'You pressed Yes');
      },
      onCancel: () {
        Get.snackbar('Cancelled', 'You pressed No');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showMyDialog,
          child: Text('Show Dialog'),
        ),
      ),
    );
  }
}
