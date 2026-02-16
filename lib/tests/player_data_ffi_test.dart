import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:six_in_a_row/data/playerData.dart'; // adjust import if needed

void main() {
  setUpAll(() {
    sqfliteFfiInit(); // initialize ffi
    databaseFactory = databaseFactoryFfi; // route sqflite to ffi backend
  });

  test('insert and query player', () async {
    // Ensure fresh DB path for test (PlayerData uses getDatabasesPath())
    final db = await PlayerData.initDatabase();
    // Optionally clear table
    await db.delete('players');
    // Insert a player
    await PlayerData.insert('players', {
      'PlayerName': 'TestPlayer',
      'wins': 1,
      'losses': 0,
      'HighestScore': 100,
      'totalTwelves': 0,
      'TotalScore': 100,
      'GamesPlayed': 1
    });

    // Query using the same method that returns nulls in your app
    final rows = await PlayerData.getDataWhere(
      'players',
      ['id', 'PlayerName', 'wins'],
      'PlayerName = ?',
      ['TestPlayer'],
    );

    // Print for debugging
    print('Queried rows: $rows');

    expect(rows, isNotEmpty);
    expect(rows.first['PlayerName'], 'TestPlayer');
  });
}