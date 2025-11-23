// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX TextField Binding Example',
    home: TextFieldBindingScreen(),
  ));
}

// Step 3: Controller with RxString
class TextController extends GetxController {
  var text = ''.obs; // RxString
}

class TextFieldBindingScreen extends StatelessWidget {
  // Initialize controller
  final TextController textController = Get.put(TextController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bind TextField to RxString')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                textController.text.value = value; // update RxString
              },
            ),
            SizedBox(height: 20),
            // Display real-time value
            Obx(() => Text(
              'You typed: ${textController.text}',
              style: TextStyle(fontSize: 20),
            )),
          ],
        ),
      ),
    );
  }
}
