// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX RxList Example',
    home: ListScreen(),
  ));
}

// Step 3: Create controller with RxList
class ListController extends GetxController {
  var items = <String>[].obs;

  void addItem(String item) {
    items.add(item);
  }

  void removeItem(int index) {
    items.removeAt(index);
  }
}

class ListScreen extends StatelessWidget {
  final ListController listController = Get.put(ListController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RxList with ListView')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      listController.addItem(textEditingController.text);
                      textEditingController.clear();
                    }
                  },
                  child: Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: listController.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listController.items[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      listController.removeItem(index);
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
