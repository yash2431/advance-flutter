import 'laB_9_2_1.dart';

void main() {
  Student student = Student(name: 'Dell naz', age: 20, grade: 'A');

  Map<String, dynamic> studentMap = student.toMap();
  print('Student Map: $studentMap');

  Student newStudent = Student.fromMap(studentMap);
  print('New Student Object: $newStudent');
}
