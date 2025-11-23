import 'package:get/get.dart';
import 'laB_9_2_1.dart';


class StudentController extends GetxController {
  var studentList = <Student>[].obs;

  void loadStudents() {
    studentList.value = [
      Student(id: 1, name: "Alice", age: 20, grade: "A"),
      Student(id: 2, name: "Bob", age: 21, grade: "B"),
      Student(id: 3, name: "Charlie", age: 22, grade: "A"),
    ];
  }
}
