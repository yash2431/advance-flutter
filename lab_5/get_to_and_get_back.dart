// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Navigation Example',
    home: FirstScreen(),
  ));
}

// First screen with button to navigate
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(SecondScreen()); // Navigate to SecondScreen
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

// Second screen with button to go back
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Go back to previous screen
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back(); // Go back to FirstScreen
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
