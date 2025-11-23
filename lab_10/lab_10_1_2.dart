import 'package:get/get.dart';
import 'lab_10_1_1.dart';

class StudentController extends GetxController {
  var students = [].obs; // list of students (we won't use now, but useful)

  Future<void> insertStudent(String name, int age, String course) async {
    final student = {
      'name': name,
      'age': age,
      'course': course,
    };
    await DBHelper.insertStudent(student);
    // optionally, refresh list or show a snackbar
    Get.snackbar('Success', 'Student added!');
  }
}
