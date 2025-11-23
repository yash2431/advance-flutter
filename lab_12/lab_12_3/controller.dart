// lib/controllers/todo_controller.dart
import 'package:get/get.dart';
import 'services.dart';
import 'model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  final api = TodoApiService();

  @override
  void onInit() {
    fetchAllTodos();
    super.onInit();
  }

  void fetchAllTodos() async {
    final response = await api.fetchTodos();
    if (response.statusCode == 200) {
      todos.value = (response.body as List)
          .map((e) => Todo.fromJson(e))
          .toList();
    }
  }

  void addNewTodo(String title) async {
    final newTodo = Todo(title: title, completed: false);
    final response = await api.addTodo(newTodo);
    if (response.statusCode == 201) {
      todos.insert(0, Todo.fromJson(response.body));
    }
  }

  void toggleComplete(Todo todo) async {
    todo.completed = !todo.completed;
    await api.updateTodo(todo.id!, todo);
    todos.refresh();
  }

  void deleteTodoWithDialog(int id) {
    Get.defaultDialog(
      title: "Delete Todo",
      middleText: "Are you sure?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Get.theme.dialogBackgroundColor,
      onConfirm: () async {
        final response = await api.deleteTodo(id);
        if (response.statusCode == 200) {
          todos.removeWhere((t) => t.id == id);
          Get.back();
          Get.snackbar("Deleted", "Todo removed",
              snackPosition: SnackPosition.BOTTOM);
        }
      },
    );
  }
}
