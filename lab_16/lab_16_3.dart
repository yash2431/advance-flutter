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
      home: DeleteFileScreen(),
    );
  }
}

class DeleteFileScreen extends StatefulWidget {
  const DeleteFileScreen({super.key});

  @override
  State<DeleteFileScreen> createState() => _DeleteFileScreenState();
}

class _DeleteFileScreenState extends State<DeleteFileScreen> {
  final TextEditingController _pathController = TextEditingController();
  String statusMessage = "Enter the full file path to delete.";

  Future<void> requestPermission() async {
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  Future<void> deleteFile() async {
    await requestPermission();

    if (await Permission.manageExternalStorage.isGranted) {
      try {
        File file = File(_pathController.text.trim());

        if (await file.exists()) {
          await file.delete();
          setState(() {
            statusMessage = "File deleted successfully.";
          });
        } else {
          setState(() {
            statusMessage = "File not found.";
          });
        }
      } catch (e) {
        setState(() {
          statusMessage = "Error deleting file: $e";
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
        title: const Text("Delete File from External Storage"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pathController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter full file path",
                hintText: "/storage/emulated/0/Download/myfile.txt",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: deleteFile,
              icon: const Icon(Icons.delete),
              label: const Text("Delete File"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(statusMessage),
          ],
        ),
      ),
    );
  }
}
