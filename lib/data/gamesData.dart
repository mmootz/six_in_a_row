import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'gamesdata.db'),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE games(id INTEGER PRIMARY KEY, '
          'Active TEXT, '
          'FirstPlayer TEXT, SecondPlayer TEXT, '
          'ThirdPlayer TEXT, ForthPlayer TEXT,'
          'FirstPlayerScore INTEGER, SecondPlayerScore INTEGER, '
          'ThirdPlayerScore INTEGER, ForthPlayerScore INTEGER, '
          'Winnner TEXT, WinningScore INTEGER,'
          'Date TEXT, LastRound INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(
      String table, Map<String, dynamic> values, String data, List args) async {
    final db = await DBHelper.database();
    db.update(table, values, where: data, whereArgs: args);

  }

  static Future<List<Map<String, dynamic>>> getDataWhere(String table,
      List<String> columns, String whereColumn, List whereArgs) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query(table,
        columns: columns, where: whereColumn, whereArgs: whereArgs);

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getGames() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('Games', orderBy: "Date DESC");

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query(table);

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getRawData(String command) async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.rawQuery(command);

    return maps;
  }

  static Future<void> delete(String table, String data, List args) async {
    final db = await DBHelper.database();
    db.delete(table, where: data, whereArgs: args);
    //db.rawDelete(sql)
  }
}
