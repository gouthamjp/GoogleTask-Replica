import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'task.db'),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE tasks(task TEXT PRIMARY KEY, date TEXT)');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> getData(String table)async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
