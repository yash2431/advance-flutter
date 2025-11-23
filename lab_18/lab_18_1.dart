import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const ResponsiveGridApp());
}

class ResponsiveGridApp extends StatelessWidget {
  const ResponsiveGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Responsive Grid with GetX",
      debugShowCheckedModeBanner: false,
      home: const ResponsiveGridPage(),
    );
  }
}

class ResponsiveGridPage extends StatelessWidget {
  const ResponsiveGridPage({super.key});

  int _getCrossAxisCount() {
    double width = Get.width; // Using GetX instead of MediaQuery

    if (width < 600) {
      return 2; // Small screens → 2 columns
    } else if (width < 900) {
      return 3; // Medium screens → 3 columns
    } else {
      return 4; // Large screens → 4 columns
    }
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = _getCrossAxisCount();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Grid Layout (GetX)"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Item ${index + 1}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
