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
        appBar: AppBar(title: Text('POST & PUT using GetConnect')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: userController.postUser,
                child: Text('POST User'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: userController.putUser,
                child: Text('PUT User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
