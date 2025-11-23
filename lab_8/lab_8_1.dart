import 'package:flutter/material.dart';

void main() {
  runApp(const DivideByZeroApp());
}

class DivideByZeroApp extends StatelessWidget {
  const DivideByZeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divide by Zero Example',
      home: const DivideByZeroScreen(),
    );
  }
}

class DivideByZeroScreen extends StatefulWidget {
  const DivideByZeroScreen({super.key});

  @override
  State<DivideByZeroScreen> createState() => _DivideByZeroScreenState();
}

class _DivideByZeroScreenState extends State<DivideByZeroScreen> {
  final TextEditingController _numeratorController = TextEditingController();
  final TextEditingController _denominatorController = TextEditingController();
  String _result = '';

  void _divide() {
    try {
      int numerator = int.parse(_numeratorController.text);
      int denominator = int.parse(_denominatorController.text);

      if (denominator == 0) {
        throw Exception('Cannot divide by zero!');
      }

      double result = numerator / denominator;
      setState(() {
        _result = 'Result: $result';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divide by Zero Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _numeratorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter numerator'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _denominatorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter denominator'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _divide,
              child: const Text('Divide'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
