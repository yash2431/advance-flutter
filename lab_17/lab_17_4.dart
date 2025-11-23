import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orientation Based Layout',
      home: const OrientationLayoutPage(),
    );
  }
}

class OrientationLayoutPage extends StatelessWidget {
  const OrientationLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(title: const Text("Orientation Layout Example")),
      body: orientation == Orientation.portrait
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.phone_android, size: 100, color: Colors.green),
          SizedBox(height: 20),
          Text("Portrait Mode", style: TextStyle(fontSize: 24)),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.laptop, size: 100, color: Colors.blue),
          SizedBox(width: 20),
          Text("Landscape Mode", style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
