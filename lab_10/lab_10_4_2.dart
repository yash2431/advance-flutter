import 'package:get/get.dart';
import 'lab_10_4_1.dart';

class StudentController extends GetxController {
  var students = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  int page = 0;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    loadMoreStudents();
  }

  Future<void> loadMoreStudents() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    final offset = page * limit;

    final data = await DBHelper.getStudentsPaged(limit, offset);

    if (data.isNotEmpty) {
      students.addAll(data);
      page++;
    } else {
      hasMore.value = false; // no more data
    }

    isLoading.value = false;
  }

  Future<void> insertStudent(String name, int age, String course) async {
    final student = {'name': name, 'age': age, 'course': course};
    await DBHelper.insertStudent(student);
    refreshList();
  }

  void refreshList() {
    page = 0;
    hasMore.value = true;
    students.clear();
    loadMoreStudents();
  }
}
