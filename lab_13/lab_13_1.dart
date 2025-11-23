import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async Exception Handling',
      home: HomePage(), // ← put the actual UI in a separate widget
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Simulate an asynchronous task that may throw an error
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    throw Exception("Failed to fetch data"); // simulate failure
    //return "Data loaded successfully"; // simulate success
  }

  Future<void> handleAsyncOperation(BuildContext context) async {
    try {
      String result = await fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      print("Async operation completed (either success or failure).");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Async Exception Handling'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Start Async Task"),
          onPressed: () => handleAsyncOperation(context), // ← now valid context
        ),
      ),
    );
  }
}