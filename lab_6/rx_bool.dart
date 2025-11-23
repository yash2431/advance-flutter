// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX RxBool Show/Hide Example',
    home: ShowHideContentScreen(),
  ));
}

// Step 3: Controller with RxBool
class VisibilityController extends GetxController {
  var isVisible = true.obs; // RxBool

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }
}

class ShowHideContentScreen extends StatelessWidget {
  final VisibilityController visibilityController = Get.put(VisibilityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RxBool Show/Hide Example')),
      body: Center(
        child: Obx(() => visibilityController.isVisible.value
            ? Container(
          padding: EdgeInsets.all(20),
          color: Colors.blueAccent,
          child: Text(
            '🎉 This content is visible!',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        )
            : Text(
          '❗ Content is hidden',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          visibilityController.toggleVisibility();
        },
        child: Icon(Icons.visibility),
        tooltip: 'Show/Hide Content',
      ),
    );
  }
}
