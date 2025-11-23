// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Transitions Example',
    home: FirstScreen(),
  ));
}

// First Screen with buttons to choose transition
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(SecondScreen(), transition: Transition.fade);
              },
              child: Text('Go with Fade Transition'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Get.to(SecondScreen(), transition: Transition.rightToLeft);
              },
              child: Text('Go with Slide RightToLeft Transition'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Get.to(SecondScreen(), transition: Transition.zoom);
              },
              child: Text('Go with Zoom Transition'),
            ),
          ],
        ),
      ),
    );
  }
}

// Second Screen with back button
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Go back to First Screen
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back(); // Go back to First Screen
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
