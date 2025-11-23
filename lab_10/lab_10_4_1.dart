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

  // ✅ Pagination: get students with limit & offset
  static Future<List<Map<String, dynamic>>> getStudentsPaged(int limit, int offset) async {
    final dbClient = await db;
    return await dbClient.query(
      'students',
      orderBy: 'id DESC',
      limit: limit,
      offset: offset,
    );
  }
}
