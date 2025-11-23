import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'students.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            course TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertStudent(Map<String, dynamic> student) async {
    final dbClient = await db;
    return await dbClient.insert('students', student);
  }

  static Future<List<Map<String, dynamic>>> getStudents() async {
    final dbClient = await db;
    return await dbClient.query('students');
  }

  static Future<int> updateStudent(int id, Map<String, dynamic> student) async {
    final dbClient = await db;
    return await dbClient.update('students', student, where: 'id = ?', whereArgs: [student[id]]);
  }

  static Future<int> deleteStudent(int id) async {
    final dbClient = await db;
    return await dbClient.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}
