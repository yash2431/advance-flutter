import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Custom Exception Class
class InvalidAgeException implements Exception {
  final String message;
  InvalidAgeException(this.message);

  @override
  String toString() => "InvalidAgeException: $message";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Custom Exception Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Function that throws custom exception if age < 18
  void validateAge(int age) {
    if (age < 18) {
      throw InvalidAgeException("Age must be 18 or above.");
    }
  }

  void handleValidation(BuildContext context, int age) {
    try {
      validateAge(age);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Valid age: $age")),
      );
    } on InvalidAgeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unknown error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Exception Example")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Validate Age (15)"),
          onPressed: () => handleValidation(context, 15), // try 20 for valid
        ),
      ),
    );
  }
}