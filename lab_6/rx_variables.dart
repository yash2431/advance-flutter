import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Rx Variables Example',
    home: HomeScreen(),
  ));
}

class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter++;
  }
}

class HomeScreen extends StatelessWidget {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Rx Variables Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              'Counter (using Obx): ${counterController.counter}',
              style: TextStyle(fontSize: 24),
            )),

            SizedBox(height: 20),

            // Just another Obx to show same effect
            Obx(() => Text(
              'Counter (second Obx): ${counterController.counter}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            )),
          ],
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
