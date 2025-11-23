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
      home: ExternalStorageFilesScreen(),
    );
  }
}

class ExternalStorageFilesScreen extends StatefulWidget {
  const ExternalStorageFilesScreen({super.key});

  @override
  State<ExternalStorageFilesScreen> createState() =>
      _ExternalStorageFilesScreenState();
}

class _ExternalStorageFilesScreenState
    extends State<ExternalStorageFilesScreen> {
  List<FileSystemEntity> files = [];
  bool isLoading = false;
  String statusMessage = "";

  Future<void> requestPermission() async {
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  Future<void> listFiles() async {
    await requestPermission();

    if (await Permission.manageExternalStorage.isGranted) {
      setState(() {
        isLoading = true;
        files.clear();
      });

      try {
        // Access root of external storage
        Directory dir = Directory("/storage/emulated/0");

        if (await dir.exists()) {
          List<FileSystemEntity> allFiles = dir.listSync(recursive: true);

          setState(() {
            files = allFiles;
            statusMessage = "Found ${files.length} items.";
          });
        } else {
          setState(() {
            statusMessage = "External storage not found.";
          });
        }
      } catch (e) {
        setState(() {
          statusMessage = "Error reading storage: $e";
        });
      }

      setState(() {
        isLoading = false;
      });
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
        title: const Text("All Files in External Storage"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: listFiles,
          ),
        ],
      ),
      body: Column(
        children: [
          if (statusMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(statusMessage),
            ),
          if (isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  String name = files[index].path.split("/").last;
                  return ListTile(
                    leading: Icon(
                      files[index] is File
                          ? Icons.insert_drive_file
                          : Icons.folder,
                    ),
                    title: Text(name),
                    subtitle: Text(files[index].path),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: listFiles,
        child: const Icon(Icons.search),
      ),
    );
  }
}
