import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class gameData {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'gamesdata.db'),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE games(id INTEGER PRIMARY KEY, '
          'Active TEXT, '
          'FirstPlayer TEXT, SecondPlayer TEXT, '
          'ThirdPlayer TEXT, FourthPlayer TEXT,'
          'FirstPlayerScore INTEGER, SecondPlayerScore INTEGER, '
          'ThirdPlayerScore INTEGER, FourthPlayerScore INTEGER, '
          'Winner TEXT, WinningScore INTEGER,'
          'Date TEXT, LastRound INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await gameData.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(
      String table, Map<String, dynamic> values, String data, List args) async {
    final db = await gameData.database();
    db.update(table, values, where: data, whereArgs: args);

  }

  static Future<List<Map<String, dynamic>>> getDataWhere(String table,
      List<String> columns, String whereColumn, List whereArgs) async {
    final db = await gameData.database();
    final List<Map<String, dynamic>> maps = await db.query(table,
        columns: columns, where: whereColumn, whereArgs: whereArgs);

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getGames() async {
    final db = await gameData.database();
    // DESC doesn't do anything but allows you to sort by date correctly
    final List<Map<String, dynamic>> maps = await db.query('Games', orderBy: "date(Date) DESC");
    // just reversing the map has the desired affect.
    return maps.reversed.toList();
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await gameData.database();
    final List<Map<String, dynamic>> maps = await db.query(table);

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getRawData(String command) async {
    final db = await gameData.database();
    final List<Map<String, dynamic>> maps = await db.rawQuery(command);

    return maps;
  }

  static Future<void> delete(String table, String data, List args) async {
    final db = await gameData.database();
    db.delete(table, where: data, whereArgs: args);

  }
}
