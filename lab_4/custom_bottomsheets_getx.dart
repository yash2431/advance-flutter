// file: main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Custom BottomSheet Example',
    home: CustomBottomSheetScreen(),
  ));
}

class CustomBottomSheetScreen extends StatelessWidget {
  // Function to show custom bottom sheet with auto-close
  void showAutoCloseBottomSheet({
    required double heightFraction,
    required String message,
    required Color color,
    Duration autoCloseAfter = const Duration(seconds: 3),
  }) {
    Get.bottomSheet(
      Container(
        height: Get.height * heightFraction,
        color: color,
        child: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );

    // Auto-close after duration
    Timer(autoCloseAfter, () {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Custom BottomSheet Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => showAutoCloseBottomSheet(
                heightFraction: 0.25, // 25% of screen
                message: 'This is a short bottom sheet',
                color: Colors.blue,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Show Short BottomSheet'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showAutoCloseBottomSheet(
                heightFraction: 0.5, // 50% of screen
                message: 'This is a medium bottom sheet',
                color: Colors.green,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Show Medium BottomSheet'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showAutoCloseBottomSheet(
                heightFraction: 0.8, // 80% of screen
                message: 'This is a large bottom sheet',
                color: Colors.orange,
                autoCloseAfter: Duration(seconds: 5), // auto close after 5 seconds
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Show Large BottomSheet (Auto-close in 5s)'),
            ),
          ],
        ),
      ),
    );
  }
}
