import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class PlayerDatabase {
  late Database _database;

  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final databasePath = path.join(dbPath, 'players.db');

    _database = await openDatabase(databasePath, version: 1,
        onCreate: (db, version) async {
           await db.execute(
            'CREATE TABLE players(id INTEGER PRIMARY KEY, '
                'playername TEXT, '
                'wins INTEGER, '
                'losses INTEGER, '
                'Highestscore INTEGER,'
                'totalTwelves INTEGER,'
                'totalscore INTEGER,'
                'Gamesplayed INTEGER )',
          );
          await db.execute(
            'CREATE TABLE games(id INTEGER PRIMARY KEY, '
                'Active TEXT, '
                'FirstPlayer TEXT, SecondPlayer TEXT, '
                'ThirdPlayer TEXT, ForthPlayer TEXT,'
                'FirstPlayerScore INTEGER, SecondPlayerScore INTEGER, '
                'ThirdPlayerScore INTEGER, ForthPlayerScore INTEGER, '
                'Winnner TEXT, WinningScore INTEGER,'
                'Date TEXT, LastRound INTEGER)',
          );
        });
  }

  Future<void> insertPlayer(String playerName) async {
    await _database.insert('players', {'playername': playerName});
  }

  Future<List<Map<String, dynamic>>> getPlayers() async {
    return _database.query('players');
  }
}



