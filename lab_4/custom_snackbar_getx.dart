// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Custom SnackBar Example',
    home: CustomSnackBarScreen(),
  ));
}

class CustomSnackBarScreen extends StatelessWidget {
  void showCustomSnackBar({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
    required SnackPosition position,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: position,
      margin: EdgeInsets.all(12),
      borderRadius: 10,
      icon: Icon(icon, color: Colors.white),
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Custom SnackBar Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => showCustomSnackBar(
                title: 'Success',
                message: 'This is a success snackbar!',
                color: Colors.green,
                icon: Icons.check_circle,
                position: SnackPosition.TOP,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Show Success SnackBar (Top)'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showCustomSnackBar(
                title: 'Warning',
                message: 'This is a warning snackbar!',
                color: Colors.orange,
                icon: Icons.warning,
                position: SnackPosition.BOTTOM,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Show Warning SnackBar (Bottom)'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showCustomSnackBar(
                title: 'Error',
                message: 'This is an error snackbar!',
                color: Colors.red,
                icon: Icons.error,
                position: SnackPosition.TOP,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Show Error SnackBar (Top)'),
            ),
          ],
        ),
      ),
    );
  }
}
