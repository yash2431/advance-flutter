// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Pass Data Example',
    home: FirstScreen(),
  ));
}

// First screen
class FirstScreen extends StatelessWidget {
  final String dataToPass = "Hello from First Screen!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Pass data to SecondScreen using arguments
            Get.to(SecondScreen(), arguments: dataToPass);
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

// Second screen
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Receive data from Get.arguments
    final receivedData = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Text(
          'Received data: $receivedData',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
