// lib/controllers/user_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services.dart';
class UserController extends GetxController {
  final ApiService api = ApiService();

  void deleteUserWithDialog(BuildContext context, int id) {
    Get.defaultDialog(
      title: "Delete User",
      middleText: "Are you sure you want to delete this user?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final response = await api.deleteUser(id);

        Get.back(); // Close the dialog

        if (response.statusCode == 200 || response.statusCode == 204) {
          Get.snackbar("Success", "User deleted successfully",
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Error", "Failed to delete user",
              snackPosition: SnackPosition.BOTTOM);
        }
      },
    );
  }
}
