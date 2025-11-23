import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WriteAnyFileScreen(),
    );
  }
}

class WriteAnyFileScreen extends StatefulWidget {
  const WriteAnyFileScreen({super.key});

  @override
  State<WriteAnyFileScreen> createState() => _WriteAnyFileScreenState();
}

class _WriteAnyFileScreenState extends State<WriteAnyFileScreen> {
  final TextEditingController _controller = TextEditingController();
  String statusMessage = "Enter text and press Save.";

  Future<void> requestManageExternalStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      statusMessage = "Permission granted!";
    } else {
      statusMessage = "Permission denied.";
    }
    setState(() {});
  }

  Future<void> writeFileAnywhere() async {
    if (!await Permission.manageExternalStorage.isGranted) {
      await requestManageExternalStoragePermission();
    }
    if (await Permission.manageExternalStorage.isGranted) {
      try {
        // Example: Writing to Downloads folder
        Directory dir = Directory("/storage/emulated/0/Download");
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        File file = File("${dir.path}/myfile.txt");
        await file.writeAsString(_controller.text);

        setState(() {
          statusMessage = "File saved at: ${file.path}";
        });
      } catch (e) {
        setState(() {
          statusMessage = "Error: $e";
        });
      }
    } else {
      setState(() {
        statusMessage = "Cannot write without permission.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write File (Any Folder)"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter content to save",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: writeFileAnywhere,
              icon: const Icon(Icons.save),
              label: const Text("Save to Downloads"),
            ),
            const SizedBox(height: 20),
            Text(statusMessage),
          ],
        ),
      ),
    );
  }
}
