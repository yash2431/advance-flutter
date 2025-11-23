// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('To-Do App using API')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: "New Todo",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        controller.addNewTodo(textController.text);
                        textController.clear();
                      }
                    },
                    child: Text("Add"),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) {
                    final todo = controller.todos[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => controller.toggleComplete(todo),
                      ),
                      title: Text(todo.title),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            controller.deleteTodoWithDialog(todo.id!),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
