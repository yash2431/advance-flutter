import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_10_4_2.dart';

void main() {
  runApp(GetMaterialApp(
    home: LazyLoadPage(),
  ));
}

class LazyLoadPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lazy Loading (SQLite)')),
      body: Column(
        children: [
          // Form to add new student
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: ageController, decoration: InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
                TextField(controller: courseController, decoration: InputDecoration(labelText: 'Course')),
                SizedBox(height: 8),
                ElevatedButton(
                  child: Text('Add Student'),
                  onPressed: () {
                    final name = nameController.text;
                    final age = int.tryParse(ageController.text) ?? 0;
                    final course = courseController.text;
                    controller.insertStudent(name, age, course);
                    nameController.clear();
                    ageController.clear();
                    courseController.clear();
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() => NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200 &&
                    !controller.isLoading.value &&
                    controller.hasMore.value) {
                  controller.loadMoreStudents();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.students.length + (controller.hasMore.value ? 1 : 0),
                itemBuilder: (_, index) {
                  if (index < controller.students.length) {
                    final student = controller.students[index];
                    return ListTile(
                      title: Text(student['name']),
                      subtitle: Text('Age: ${student['age']} | Course: ${student['course']}'),
                    );
                  } else {
                    return Center(child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ));
                  }
                },
              ),
            )),
          ),
        ],
      ),
    );
  }
}
