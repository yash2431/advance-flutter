import 'dart:io'; // Needed for SocketException
import 'package:flutter/material.dart';

void main() {
  runApp(const SpecificExceptionApp());
}

class SpecificExceptionApp extends StatelessWidget {
  const SpecificExceptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handle Specific Exceptions',
      home: const SpecificExceptionScreen(),
    );
  }
}

class SpecificExceptionScreen extends StatefulWidget {
  const SpecificExceptionScreen({super.key});

  @override
  State<SpecificExceptionScreen> createState() => _SpecificExceptionScreenState();
}

class _SpecificExceptionScreenState extends State<SpecificExceptionScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _message = '';

  Future<void> _handleExceptions() async {
    try {
      // Try parsing user input; may throw FormatException
      int number = int.parse(_numberController.text);
      print('Parsed number: $number');

      // Simulate a fake network request; let's assume no internet
      throw const SocketException('No Internet connection');

    } on FormatException catch (e) {
      setState(() {
        _message = 'FormatException: Please enter a valid integer.\nDetails: $e';
      });
    } on SocketException catch (e) {
      setState(() {
        _message = 'SocketException: Network error occurred.\nDetails: $e';
      });
    } catch (e) {
      setState(() {
        _message = 'Other Exception: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handle Specific Exceptions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter an integer',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleExceptions,
              child: const Text('Check Exceptions'),
            ),
            const SizedBox(height: 16),
            Text(
              _message,
              style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
