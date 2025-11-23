import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  var files = <String>[].obs; // List of file URLs

  /// Pick and upload file
  Future<void> uploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        // Upload to firebase storage
        await storage.ref("uploads/$fileName").putFile(file);

        // Get download URL
        String downloadUrl =
        await storage.ref("uploads/$fileName").getDownloadURL();

        files.add(downloadUrl); // Add to observable list
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }

  /// Retrieve all uploaded files
  Future<void> loadFiles() async {
    final ListResult result = await storage.ref("uploads").listAll();
    files.clear();
    for (var item in result.items) {
      String url = await item.getDownloadURL();
      files.add(url);
    }
  }
}
