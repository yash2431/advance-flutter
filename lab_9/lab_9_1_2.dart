import 'package:flutter/material.dart';
import 'lab_9_1_1.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = DBHelper();
  await db.insertStudent('Dell naz', 21); // Optional test insert
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('SQLite Demo')),
        body: Center(
          child: Text('Student database created and initialized!'),
        ),
      ),
    );
  }
}
