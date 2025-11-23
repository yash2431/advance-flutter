import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layout',
      home: const ResponsivePage(),
    );
  }
}

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Condition to determine platform based on width
    bool isWeb = screenWidth > 700;

    return Scaffold(
      backgroundColor: isWeb ? Colors.blueGrey : Colors.greenAccent,
      body: Center(
        child: Text(
          isWeb ? "WEB" : "MOBILE",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: isWeb ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
