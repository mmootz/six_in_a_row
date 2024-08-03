import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class PlayerData {
  static Future<Database> initDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'playerData.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE players(id INTEGER PRIMARY KEY, '
              'PlayerName TEXT, '
              'wins INTEGER, '
              'losses INTEGER, '
              'HighestScore INTEGER,'
              'totalTwelves INTEGER,'
              'TotalScore INTEGER,'
              'GamesPlayed INTEGER )');
    }, version: 1);
  }

  static Future<int> insert(String table, Map<String, Object> data) async {
    final db = await PlayerData.initDatabase();

    return await db!.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<List<Map<String, dynamic>>> getDataWhere(String table,
      List<String> columns, String whereColumn, List whereArgs) async {
    final db = await PlayerData.initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(table,
        columns: columns, where: whereColumn, whereArgs: whereArgs);

    return maps;
  }

  static Future<void> update(
      String table, Map<String, dynamic> values, String data, List args) async {
    final db = await PlayerData.initDatabase();
    db.update(table, values, where: data, whereArgs: args);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await PlayerData.initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(table);
    return maps;
  }

  static Future<List<Map<String, dynamic>>> getRawData(String command) async {
    final db = await PlayerData.initDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(command);
    return maps;
  }

  static Future<void> delete(String table, String data, List args) async {
    final db = await PlayerData.initDatabase();
    db.delete(table, where: data, whereArgs: args);
    //db.rawDelete(sql)
  }

  static Future<bool> checkExits(String playerName) async {
    final db = await PlayerData.initDatabase();
    var check = await db.query('players', where: 'PlayerName = ?', whereArgs: [playerName] );
    return check.isNotEmpty;

  }
}
