import 'package:flutter/material.dart';
import 'package:six/data/gamesData.dart';
import 'package:six/widgets/getScores.dart';

class Game {
  static Future<List> getGames() async {
    List foundGames = [];
    final listPlayers = await DBHelper.getData('games');
    for (var element in listPlayers) {
      foundGames.add(element['id'].toString());
    }

    return foundGames;
  }

  static Future<Map<String, int>> getScores() async {
    //List foundGames = [];
    Map<String, int> scores = {};

    final queryNames = await DBHelper.getDataWhere(
        'games', ['FirstPlayer', 'SecondPlayer'], 'Active = ?', ['Yes']);
    final queryScores = await DBHelper.getDataWhere('games',
        ['FirstPlayerScore', 'SecondPlayerScore'], 'Active = ?', ['Yes']);
    final queryData = await DBHelper.getData('games');

    scores[queryNames[0].entries.first.value.toString()] =
        queryScores[0].entries.first.value;
    scores[queryNames[0].entries.elementAt(1).value.toString()] =
        queryScores[0].entries.elementAt(1).value;
     debugPrint(scores.toString());
    return scores;
  }

  static Future<void> newGame(List playernames) async {
    int newID = 0;
    final getid = await DBHelper.getRawData('SELECT MAX(id) FROM games');
    if (getid[0]['MAX(id)'] != null) {
      newID = getid[0]['MAX(id)'];
      newID++;
    }
    // clear all other active games
    DBHelper.update('games', {'Active': 'no'}, 'Active = ?', ['Yes']);
    debugPrint('GameID $newID');
    debugPrint('players: $playernames');
    DBHelper.insert('games', {
      'id': newID,
      'Active': 'Yes',
      'FirstPlayer': playernames[0],
      'SecondPlayer': playernames[1],
      // 'ThirdPlayer': "null",
      // 'ForthPlayer': "null",
      // 'Winner' : "null",
      'Date': "2022-11-25 19:29:32:321"
    });
  }

  static Future<void> updateGame(Map<String, dynamic> values) async {
    DBHelper.update('games', values, 'Active = ?', ['Yes']);
    debugPrint('update: $values');
  }

  static Future<void> deleteGame(List gameids) async {
    DBHelper.delete('players', 'playername = ?', gameids);
  }
}
