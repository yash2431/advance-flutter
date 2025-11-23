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
      title: "Responsive Widgets with GetX",
      home: const ResponsiveScreen(),
    );
  }
}

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Responsive Widgets Example")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use constraints.maxWidth instead of Get.width for live responsiveness
          if (constraints.maxWidth < 600) {
            return const SmallScreenWidget();
          } else {
            return const LargeScreenWidget();
          }
        },
      ),
    );
  }
}

class SmallScreenWidget extends StatelessWidget {
  const SmallScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.blue[100],
        child: const Text(
          "📱 Small Screen Layout",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }
}

class LargeScreenWidget extends StatelessWidget {
  const LargeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.green[100],
        child: const Text(
          "💻 Large Screen Layout",
          style: TextStyle(fontSize: 28, color: Colors.green),
        ),
      ),
    );
  }
}
