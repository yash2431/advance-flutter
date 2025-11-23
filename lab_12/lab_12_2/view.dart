// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Delete User with Dialog')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              userController.deleteUserWithDialog(context, 1); // Pass user ID
            },
            child: Text('Delete User'),
          ),
        ),
      ),
    );
  }
}
