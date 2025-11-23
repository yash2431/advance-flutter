import 'package:get/get.dart';
import 'lab_10_2_1.dart';

class StudentController extends GetxController {
  var students = [].obs; // Observable list

  @override
  void onInit() {
    super.onInit();
    loadStudents();
  }

  Future<void> loadStudents() async {
    final data = await DBHelper.getStudents();
    students.value = data;
  }

  Future<void> insertStudent(String name, int age, String course) async {
    await DBHelper.insertStudent({'name': name, 'age': age, 'course': course});
    loadStudents();
  }

  Future<void> updateStudent(int id, String name, int age, String course) async {
    await DBHelper.updateStudent(id, {'name': name, 'age': age, 'course': course});
    loadStudents();
  }

  Future<void> deleteStudent(int id) async {
    await DBHelper.deleteStudent(id);
    loadStudents();
  }
}
