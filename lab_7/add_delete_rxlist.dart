// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'RxList Add/Delete Example',
    home: RxListCrudScreen(),
  ));
}

// Step 3: Controller with RxList
class ItemController extends GetxController {
  var items = <String>[].obs;

  void addItem(String newItem) {
    items.add(newItem);
  }

  void removeItem(int index) {
    items.removeAt(index);
  }
}

class RxListCrudScreen extends StatelessWidget {
  final ItemController controller = Get.put(ItemController());
  final TextEditingController textController = TextEditingController();

  RxListCrudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RxList Add/Delete Example')),
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
                      hintText: 'Enter item name',
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
                return ListTile(
                  title: Text(controller.items[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.removeItem(index);
                    },
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
