// lib/services/todo_api_service.dart
import 'package:get/get.dart';
import 'model.dart';

class TodoApiService extends GetConnect {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<Response> fetchTodos() => get('$baseUrl/todos?_limit=10');

  Future<Response> addTodo(Todo todo) =>
      post('$baseUrl/todos', todo.toJson());

  Future<Response> updateTodo(int id, Todo todo) =>
      put('$baseUrl/todos/$id', todo.toJson());

  Future<Response> deleteTodo(int id) =>
      delete('$baseUrl/todos/$id');
}
