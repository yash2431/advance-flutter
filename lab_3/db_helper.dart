import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static const String DB_NAME = 'mydb.db';
  static const String TABLE_USER = 'TBL_USER';

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static initDb() async {
    String dbPath = join(await getDatabasesPath(), DB_NAME);
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $TABLE_USER (
          UID INTEGER PRIMARY KEY AUTOINCREMENT,
          Name TEXT NOT NULL,
          City TEXT NOT NULL,
          Gender TEXT NOT NULL
        )
      ''');
    });
  }

  static Future<int> insertUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.insert(TABLE_USER, user);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    var dbClient = await db;
    return await dbClient.query(TABLE_USER);
  }

  static Future<int> updateUser(int uid, Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.update(TABLE_USER, user, where: 'UID=?', whereArgs: [uid]);
  }

  static Future<int> deleteUser(int uid) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE_USER, where: 'UID=?', whereArgs: [uid]);
  }
}
