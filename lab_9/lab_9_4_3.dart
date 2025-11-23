import 'package:flutter/material.dart';
import 'lab_9_4_1.dart';
import 'lab_9_4_2.dart';
import 'lab_9_4_4.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DBHelper.database;

  int courseId = await db.insert('courses', Course(name: 'Mathematics').toMap());

  await db.insert('students', Student(name: 'Alice', age: 20, courseId: courseId).toMap());

  List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT students.name AS student_name, age, courses.name AS course_name
    FROM students
    JOIN courses ON students.course_id = courses.id
  ''');

  for (var row in result) {
    print('Student: ${row['student_name']}, Age: ${row['age']}, Course: ${row['course_name']}');
  }
}
