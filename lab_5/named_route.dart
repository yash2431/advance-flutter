// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Named Routes Example',
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => FirstScreen()),
      GetPage(name: '/second', page: () => SecondScreen()),
    ],
  ));
}

// First Screen
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
            Get.toNamed('/second'); // Navigate to Second Screen by name
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

// Second Screen
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
            Get.back(); // Go back to First Screen
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
