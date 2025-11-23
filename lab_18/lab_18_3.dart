import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dynamic Font Size with GetX",
      home: const ResponsiveTextScreen(),
    );
  }
}

class ResponsiveTextScreen extends StatelessWidget {
  const ResponsiveTextScreen({super.key});

  double getFontSize() {
    double screenWidth = Get.width;

    if (screenWidth < 400) {
      return 16; // small screen (mobile)
    } else if (screenWidth < 800) {
      return 22; // medium screen (tablet)
    } else {
      return 28; // large screen (desktop/web)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Font Size Example")),
      body: Center(
        child: Text(
          "Dynamic Font Size Text",
          style: TextStyle(
            fontSize: getFontSize(),
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
