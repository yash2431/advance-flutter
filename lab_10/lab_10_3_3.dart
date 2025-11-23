import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_10_3_2.dart';

void main() {
  runApp(GetMaterialApp(
    home: StudentSearchPage(),
  ));
}

class StudentSearchPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student List & Search')),
      body: Column(
        children: [
          // ✅ Search box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by name or course',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.filterStudents(value);
              },
            ),
          ),

          // ✅ List
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredStudents.length,
              itemBuilder: (_, index) {
                final student = controller.filteredStudents[index];
                return ListTile(
                  title: Text(student['name']),
                  subtitle: Text('Age: ${student['age']} | Course: ${student['course']}'),
                );
              },
            )),
          ),

          // ✅ Form to insert new student
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
