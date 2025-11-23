import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
      home: FilePickerReader(),
    );
  }
}

class FilePickerReader extends StatefulWidget {
  const FilePickerReader({super.key});

  @override
  State<FilePickerReader> createState() => _FilePickerReaderState();
}

class _FilePickerReaderState extends State<FilePickerReader> {
  String fileContent = "No file selected.";

  Future<void> pickAndReadFile() async {
    // Step 1: Ask permission for Android only
    if (Platform.isAndroid) {
      if (!await Permission.storage.request().isGranted) {
        setState(() {
          fileContent = "Storage permission denied.";
        });
        return;
      }
    }

    // Step 2: Open file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Allow all file types
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      try {
        // Step 3: Read file contents as string
        String contents = await file.readAsString();
        setState(() {
          fileContent = contents;
        });
      } catch (e) {
        setState(() {
          fileContent = "Error reading file: $e";
        });
      }
    } else {
      setState(() {
        fileContent = "No file selected.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Any File"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(fileContent),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: pickAndReadFile,
        icon: const Icon(Icons.file_open),
        label: const Text("Pick File"),
      ),
    );
  }
}

