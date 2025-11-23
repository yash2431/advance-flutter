import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_19_3_1.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Sign In with Google"),
          onPressed: () {
            authController.signInWithGoogle();
          },
        ),
      ),
    );
  }
}
