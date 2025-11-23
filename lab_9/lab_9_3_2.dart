import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_9_3_1.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    controller.loadStudents();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Student List')),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.studentList.length,
            itemBuilder: (context, index) {
              final student = controller.studentList[index];
              return ListTile(
                leading: CircleAvatar(child: Text(student.id.toString())),
                title: Text(student.name),
                subtitle: Text('Age: ${student.age}, Grade: ${student.grade}'),
              );
            },
          );
        }),
      ),
    );
  }
}
