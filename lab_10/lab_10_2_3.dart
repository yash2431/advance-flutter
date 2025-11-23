import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_10_2_2.dart';

void main() {
  runApp(GetMaterialApp(
    home: StudentListPage(),
  ));
}

class StudentListPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();

  void showEditDialog(BuildContext context, Map student) {
    nameController.text = student['name'];
    ageController.text = student['age'].toString();
    courseController.text = student['course'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Update Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: ageController, decoration: InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
            TextField(controller: courseController, decoration: InputDecoration(labelText: 'Course')),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            child: Text('Update'),
            onPressed: () {
              final id = student['id'];
              final name = nameController.text;
              final age = int.tryParse(ageController.text) ?? 0;
              final course = courseController.text;
              controller.updateStudent(id, name, age, course);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    nameController.clear();
    ageController.clear();
    courseController.clear();

    return Scaffold(
      appBar: AppBar(title: Text('Student List')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.students.length,
              itemBuilder: (_, index) {
                final student = controller.students[index];
                return ListTile(
                  title: Text(student['name']),
                  subtitle: Text('Age: ${student['age']}, Course: ${student['course']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => showEditDialog(context, student)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => controller.deleteStudent(student['id'])),
                    ],
                  ),
                );
              },
            )),
          ),
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
        ],
      ),
    );
  }
}
