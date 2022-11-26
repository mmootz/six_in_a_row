import 'package:flutter/material.dart';
import 'package:six/data/gamesData.dart';

class Game {
  static Future<List> getGames() async {
    List foundGames = [];
    final listPlayers = await DBHelper.getData('games');
    for (var element in listPlayers) {
      foundGames.add(element['id'].toString());
    }

    return foundGames;
  }

  static Future<void> newGame(List playernames) async {
    int newID = 0;
    final getid = await DBHelper.getRawData('SELECT MAX(id) FROM games');
    if (getid[0]['MAX(id)'] != null) {
      newID = getid[0]['MAX(id)'];
      newID++;

    }
    debugPrint('GameID $newID');
    debugPrint('players: $playernames');
    DBHelper.insert('games',
        {'id': newID,
          'FirstPlayer': playernames[0],
          'SecondPlayer': playernames[1],
          // 'ThirdPlayer': "null",
          // 'ForthPlayer': "null",
          // 'Winner' : "null",
          'Date' : "2022-11-25 19:29:32:321"}
        );
  }

  static Future<void> deleteGame(List gameids) async {
    DBHelper.delete('players', 'playername = ?', gameids);
  }
}
