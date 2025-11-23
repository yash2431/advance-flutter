import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Padding Example',
      home: const ResponsivePaddingPage(),
    );
  }
}

class ResponsivePaddingPage extends StatelessWidget {
  const ResponsivePaddingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Apply more padding for larger screens
    double horizontalPadding = screenWidth > 700 ? 50 : 20;
    double verticalPadding = screenWidth > 700 ? 30 : 10;

    return Scaffold(
      appBar: AppBar(title: const Text("Responsive Padding")),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Container(
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              "Responsive Padding Applied",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
