// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Custom Dialog Example',
    home: CustomDialogScreen(),
  ));
}

class CustomDialogScreen extends StatelessWidget {
  void showCustomDialog({required String title, required String message, required Color color, required IconData icon}) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
      middleText: message,
      middleTextStyle: TextStyle(fontSize: 16),
      backgroundColor: Colors.white,
      radius: 10,
      content: Column(
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      buttonColor: color,
      onConfirm: () {
        Get.back();
        Get.snackbar('Dialog', 'You pressed OK');
      },
      textCancel: 'Cancel',
      cancelTextColor: color,
      onCancel: () {
        Get.snackbar('Dialog', 'You pressed Cancel');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Custom Dialog Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => showCustomDialog(
                title: 'Success',
                message: 'This is a success dialog!',
                color: Colors.green,
                icon: Icons.check_circle,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Show Success Dialog'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showCustomDialog(
                title: 'Warning',
                message: 'This is a warning dialog!',
                color: Colors.orange,
                icon: Icons.warning,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Show Warning Dialog'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showCustomDialog(
                title: 'Error',
                message: 'This is an error dialog!',
                color: Colors.red,
                icon: Icons.error,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Show Error Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
