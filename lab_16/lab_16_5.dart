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
      home: CheckFileScreen(),
    );
  }
}

class CheckFileScreen extends StatefulWidget {
  const CheckFileScreen({super.key});

  @override
  State<CheckFileScreen> createState() => _CheckFileScreenState();
}

class _CheckFileScreenState extends State<CheckFileScreen> {
  final TextEditingController _fileNameController =
  TextEditingController(text: "myfile.txt");
  String statusMessage = "Enter a file name to check in Downloads folder.";

  Future<void> requestPermission() async {
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  Future<void> checkFileExists() async {
    await requestPermission();

    if (await Permission.manageExternalStorage.isGranted) {
      try {
        Directory dir = Directory("/storage/emulated/0/Download");
        String filePath = "${dir.path}/${_fileNameController.text.trim()}";

        File file = File(filePath);

        if (await file.exists()) {
          setState(() {
            statusMessage = "⚠️ File already exists at: $filePath";
          });
        } else {
          setState(() {
            statusMessage = "✅ No file found. Safe to create: $filePath";
          });
        }
      } catch (e) {
        setState(() {
          statusMessage = "Error checking file: $e";
        });
      }
    } else {
      setState(() {
        statusMessage = "Permission denied.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check File in External Storage"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fileNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter File Name",
                hintText: "example.txt",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: checkFileExists,
              icon: const Icon(Icons.search),
              label: const Text("Check File"),
            ),
            const SizedBox(height: 20),
            Text(statusMessage),
          ],
        ),
      ),
    );
  }
}
