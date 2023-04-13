import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';


import 'package:flutter_test/flutter_test.dart';

import '../lib/data/playerData.dart';


void main() {
  test('endGame updates player data correctly', () async {
    // Set up the test data
    final winner = 'Alice';
    final lost = ['Bob', 'Charlie'];
    final winnerScore = 125;

    // Create a mock playerData object
    final playerData = MockPlayerData();

    // Set up the mock playerData to return some data when called
    when(playerData.getDataWhere(
        'players', ['wins'], 'playername = ?', ['Alice'])).thenAnswer((
        _) async => Future.value()
        );

  // Call the function being tested
  //await Game.endGame(winner, players, winnerScore );

  // Verify that the expected updates were made to the player data
  verify(playerData.update('players', {'wins': 6}, 'playername = ?', [winner]));
  verify(playerData.update('players', {'loses': 1}, 'playername = ?', ['Bob']));
  verify(playerData.update(
      'players', {'loses': 1}, 'playername = ?', ['Charlie']));
});

}

class MockPlayerData extends Mock implements playerData {
  @override
  Future<List<Map<String, dynamic>>> getDataWhere(String table,
      List<String> columns, String where, List<dynamic> whereArgs) {
    // Implement this method to return some mock data
    return Future.value([]);
  }

  @override
  Future<int> update(String table, Map<String, dynamic> values, String where,
      List<dynamic> whereArgs) {
    // Implement this method to return a successful update count
    debugPrint('update');
    return Future.value(1);
  }
}



