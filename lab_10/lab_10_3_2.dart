import 'package:get/get.dart';
import 'lab_10_3_1.dart';

class StudentController extends GetxController {
  var students = [].obs;           // all students from DB
  var filteredStudents = [].obs;   // list filtered by search

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final data = await DBHelper.getStudents();
    students.value = data;
    filteredStudents.value = data;
  }

  Future<void> insertStudent(String name, int age, String course) async {
    final student = {'name': name, 'age': age, 'course': course};
    await DBHelper.insertStudent(student);
    fetchStudents(); // refresh list
    Get.snackbar('Success', 'Student added!');
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.value = students;
    } else {
      filteredStudents.value = students.where((student) {
        final name = student['name'].toString().toLowerCase();
        final course = student['course'].toString().toLowerCase();
        return name.contains(query.toLowerCase()) || course.contains(query.toLowerCase());
      }).toList();
    }
  }
}
