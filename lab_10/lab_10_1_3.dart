import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_10_1_2.dart';

void main() {
  runApp(GetMaterialApp(
    home: InsertStudentPage(),
  ));
}

class InsertStudentPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: courseController,
              decoration: InputDecoration(labelText: 'Course'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Insert'),
              onPressed: () {
                final name = nameController.text;
                final age = int.tryParse(ageController.text) ?? 0;
                final course = courseController.text;

                controller.insertStudent(name, age, course);

                // clear fields
                nameController.clear();
                ageController.clear();
                courseController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
