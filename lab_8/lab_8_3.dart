import 'package:flutter/material.dart';

void main() {
  runApp(const ErrorDisplayApp());
}

class ErrorDisplayApp extends StatelessWidget {
  const ErrorDisplayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Display Example',
      home: const ErrorDisplayScreen(),
    );
  }
}

class ErrorDisplayScreen extends StatefulWidget {
  const ErrorDisplayScreen({super.key});

  @override
  State<ErrorDisplayScreen> createState() => _ErrorDisplayScreenState();
}

class _ErrorDisplayScreenState extends State<ErrorDisplayScreen> {
  final TextEditingController _numberController = TextEditingController();

  void _showSnackBar(String message) {
    // Use ScaffoldMessenger to show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDialog(String message) {
    // Use showDialog to display AlertDialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _checkNumberAndShowError() {
    String text = _numberController.text;
    if (text.isEmpty) {
      _showSnackBar('Please enter a number.');
      return;
    }

    try {
      int.parse(text);
      _showSnackBar('Number is valid!');
    } catch (e) {
      _showDialog('Invalid number format.\nDetails: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Error Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Enter a number',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkNumberAndShowError,
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}
