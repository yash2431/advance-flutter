import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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
      home: DownloadFileScreen(),
    );
  }
}

class DownloadFileScreen extends StatefulWidget {
  const DownloadFileScreen({super.key});

  @override
  State<DownloadFileScreen> createState() => _DownloadFileScreenState();
}

class _DownloadFileScreenState extends State<DownloadFileScreen> {
  final TextEditingController _urlController = TextEditingController(
    text: "https://example.com/sample.pdf",
  );

  String statusMessage = "Enter a file URL to download.";

  Future<void> requestPermission() async {
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  Future<void> downloadFile() async {
    await requestPermission();

    if (await Permission.manageExternalStorage.isGranted) {
      try {
        String url = _urlController.text.trim();
        if (url.isEmpty) {
          setState(() {
            statusMessage = "Please enter a valid URL.";
          });
          return;
        }

        // Save to Downloads folder
        Directory dir = Directory("/storage/emulated/0/Download");
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        String fileName = url.split('/').last;
        String savePath = "${dir.path}/$fileName";

        Dio dio = Dio();

        setState(() {
          statusMessage = "Downloading...";
        });

        await dio.download(
          url,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                statusMessage =
                "Downloading: ${(received / total * 100).toStringAsFixed(0)}%";
              });
            }
          },
        );

        setState(() {
          statusMessage = "File downloaded to: $savePath";
        });
      } catch (e) {
        setState(() {
          statusMessage = "Error downloading file: $e";
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
        title: const Text("Download to External Storage"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "File URL",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: downloadFile,
              icon: const Icon(Icons.download),
              label: const Text("Download File"),
            ),
            const SizedBox(height: 20),
            Text(statusMessage),
          ],
        ),
      ),
    );
  }
}
