// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'RxList<Map> CRUD Example',
    home: CrudMapScreen(),
  ));
}

// Step 3: Controller with RxList<Map>
class CrudController extends GetxController {
  var items = <Map<String, dynamic>>[].obs;

  void addItem(String name) {
    final newItem = {
      'id': DateTime.now().millisecondsSinceEpoch, // unique id
      'name': name,
    };
    items.add(newItem);
  }

  void updateItem(int index, String newName) {
    items[index]['name'] = newName;
    items.refresh(); // refresh to update UI
  }

  void deleteItem(int index) {
    items.removeAt(index);
  }
}

class CrudMapScreen extends StatelessWidget {
  final CrudController controller = Get.put(CrudController());
  final TextEditingController textController = TextEditingController();

  CrudMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RxList<Map> CRUD Example')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.addItem(textController.text.trim());
                      textController.clear();
                    }
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return ListTile(
                  title: Text(item['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showEditDialog(context, controller, index, item['name']);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.deleteItem(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  // Helper: show dialog to edit
  void _showEditDialog(BuildContext context, CrudController controller, int index, String oldName) {
    final editController = TextEditingController(text: oldName);
    Get.defaultDialog(
      title: 'Edit Item',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: editController,
          decoration: const InputDecoration(
            hintText: 'New name',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      textConfirm: 'Save',
      textCancel: 'Cancel',
      onConfirm: () {
        if (editController.text.isNotEmpty) {
          controller.updateItem(index, editController.text.trim());
          Get.back();
        }
      },
      onCancel: () {},
    );
  }
}
