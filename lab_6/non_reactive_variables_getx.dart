// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Non-Reactive Controller',
    home: HomeScreen(),
  ));
}

// Step 3: Create a controller with non-reactive variable
class CounterController extends GetxController {
  int counter = 0;

  void increment() {
    counter++;
    update(); // call update to notify GetBuilder to rebuild
  }
}

// Step 4: UI using GetBuilder to rebuild when update() is called
class HomeScreen extends StatelessWidget {
  // Initialize controller
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Non-Reactive Example')),
      body: Center(
        child: GetBuilder<CounterController>(
          builder: (controller) {
            return Text(
              'Counter value: ${controller.counter}',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
