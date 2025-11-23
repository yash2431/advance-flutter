// lib/models/todo_model.dart
class Todo {
  int? id;
  String title;
  bool completed;

  Todo({
    this.id,
    required this.title,
    this.completed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "completed": completed,
    };
  }
}
