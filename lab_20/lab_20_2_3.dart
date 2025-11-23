import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_20_2_2.dart';

class StoragePage extends StatelessWidget {
  final StorageController controller = Get.put(StorageController());

  StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Storage Example"),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.loadFiles())
        ],
      ),
      body: Obx(() {
        if (controller.files.isEmpty) {
          return const Center(child: Text("No files uploaded yet"));
        }
        return ListView.builder(
          itemCount: controller.files.length,
          itemBuilder: (context, index) {
            String fileUrl = controller.files[index];
            bool isImage = fileUrl.endsWith(".png") ||
                fileUrl.endsWith(".jpg") ||
                fileUrl.endsWith(".jpeg");

            return Card(
              child: ListTile(
                leading: isImage
                    ? Image.network(fileUrl, width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.insert_drive_file, size: 40),
                title: Text("File ${index + 1}"),
                subtitle: Text(fileUrl),
                onTap: () {
                  // Preview: open file in browser
                  Get.snackbar("File URL", fileUrl,
                      snackPosition: SnackPosition.BOTTOM);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.uploadFile(),
        child: const Icon(Icons.upload),
      ),
    );
  }
}
