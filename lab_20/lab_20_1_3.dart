import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_20_1_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Firestore CRUD',
      home: UserPage(),
    );
  }
}

class UserPage extends StatelessWidget {
  final UserController controller = Get.put(UserController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  UserPage({super.key});

  void _showUserDialog({String? id, String? oldName, int? oldAge}) {
    if (oldName != null) nameController.text = oldName;
    if (oldAge != null) ageController.text = oldAge.toString();

    Get.defaultDialog(
      title: id == null ? "Add User" : "Edit User",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(labelText: "Age"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (id == null) {
            controller.addUser(nameController.text, int.parse(ageController.text));
          } else {
            controller.updateUser(id, nameController.text, int.parse(ageController.text));
          }
          nameController.clear();
          ageController.clear();
          Get.back();
        },
        child: Text(id == null ? "Add" : "Update"),
      ),
      cancel: TextButton(
        onPressed: () {
          nameController.clear();
          ageController.clear();
          Get.back();
        },
        child: const Text("Cancel"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore CRUD")),
      body: StreamBuilder(
        stream: controller.usersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var user = docs[index];
              return ListTile(
                title: Text(user['name']),
                subtitle: Text("Age: ${user['age']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showUserDialog(
                          id: user.id,
                          oldName: user['name'],
                          oldAge: user['age'],
                        )),
                    IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.deleteUser(user.id)),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
