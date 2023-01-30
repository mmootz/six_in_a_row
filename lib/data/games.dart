import 'dart:ffi';

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

  static _getPlayerIndex(int index) {
    String playerPostion = '';
    switch (index) {
      case 0:
        {
          playerPostion = 'FirstPlayerScore';
        }
        break;
      case 1:
        {
          playerPostion = 'SecondPlayerScore';
        }
        break;
      case 2:
        {
          playerPostion = 'ThirdPlayerScore';
        }
        break;
      case 3:
        {
          playerPostion = 'ForthPlayerScore';
        }
        break;
      default:
        {
          debugPrint('Invalid index number');
          playerPostion = 'ERROR';
        }
        break;
    }
    return playerPostion;
  }

  static Future<Map<String, String>> getScoresMAP(List players) async {
    //List foundGames = [];
    Map<String, String> scores = {};

    List<String> queryNamesList = [];
    List<String> queryScoresList = [];

    switch (players.length) {
      case 2:
        {
          queryNamesList = ['firstplayer', 'secondplayer'];
        }
        break;
      case 3:
        {
          queryNamesList = ['firstplayer', 'secondplayer', 'thirdplayer'];
        }
        break;
      case 4:
        {
          queryNamesList = [
            'firstplayer',
            'secondplayer',
            'thirdplayer',
            'forthplayer'
          ];
        }
        break;
      default:
        {
          print("Invalid length");
        }
    }

    switch (players.length) {
      case 2:
        {
          queryScoresList = ['FirstPlayerScore', 'SecondPlayerScore'];
        }
        break;
      case 3:
        {
          queryScoresList = ['FirstPlayerScore', 'SecondPlayerScore', 'ThirdPlayerScore'];
        }
        break;
      case 4:
        {
          queryScoresList = [
            'FirstPlayerScore',
            'SecondPlayerScore',
            'ThirdPlayerScore',
            'ForthPlayerScore'
          ];
        }
        break;
      default:
        {
          print("Invalid length");
        }
    }

    final queryNames =
        await DBHelper.getDataWhere('games', queryNamesList, 'Active = ?', ['Yes']);

    final queryScores =
        await DBHelper.getDataWhere('games', queryScoresList, 'Active = ?', ['Yes']);

    final getCurrentScores =
        await DBHelper.getDataWhere('games', ['*'], 'Active = ?', ['Yes']);

    switch (players.length) {
      case 2:
        {
          scores[queryNames[0].entries.first.value.toString()] =
              queryScores[0].entries.first.value.toString();
          scores[queryNames[0].entries.elementAt(1).value.toString()] =
              queryScores[0].entries.elementAt(1).value.toString();
        }
        break;
      case 3:
        {
          scores[queryNames[0].entries.first.value.toString()] =
              queryScores[0].entries.first.value.toString();
          scores[queryNames[0].entries.elementAt(1).value.toString()] =
              queryScores[0].entries.elementAt(1).value.toString();
          scores[queryNames[0].entries.elementAt(2).value.toString()] =
              queryScores[0].entries.elementAt(2).value.toString();
        }
        break;
      case 4:
        {
          scores[queryNames[0].entries.first.value.toString()] =
              queryScores[0].entries.first.value;
          scores[queryNames[0].entries.elementAt(1).value.toString()] =
              queryScores[0].entries.elementAt(1).value;
          scores[queryNames[0].entries.elementAt(2).value.toString()] =
              queryScores[0].entries.elementAt(2).value;
          scores[queryNames[0].entries.elementAt(3).value.toString()] =
              queryScores[0].entries.elementAt(3).value;
        }
        break;
      default:
        {
          print("Invalid length");
        }
    }


    //debugPrint(getCurrentScores.toString());
    return scores;
  }

  static Future<List<Map<String, dynamic>>> getScoresSQL() async {
    final getCurrentScores =
        await DBHelper.getDataWhere('games', ['*'], 'Active = ?', ['Yes']);
    return getCurrentScores;
  }

  static Future<void> newGame(List playernames) async {
    String firstPlayer = playernames.first;
    String secondPlayer = playernames.elementAt(1);
    String thirdPlayer = "None"; // blank by default
    String forthPlayer = "None"; // blank by default

    // fill 3 and 4 players if they are present
    if (playernames.length == 3) {
      thirdPlayer = playernames.elementAt(2);
    }

    if (playernames.length == 4) {
      thirdPlayer = playernames.elementAt(3);
    }
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
      'FirstPlayer': firstPlayer,
      'SecondPlayer': secondPlayer,
      'ThirdPlayer': thirdPlayer,
      'ForthPlayer': forthPlayer,
      'FirstPlayerScore': 0,
      'SecondPlayerScore': 0,
      'ThirdPlayerScore': 0,
      'ForthPlayerScore': 0,
      'Date': "2022-11-25 19:29:32:321"
    });
  }
  static Future<Map<String, String>> findEditedScores(Map<String, String> edited, Map<String, String> currentScores  )
  async {
    // take in the map from the edited page and compare it to what is in database
    // find the diff and get the index for each.
    // update score with the new index.

      //edited(Map currentScores, Map editedScores ) {
      Map<String, String> foundScores = {};
      int index = 0;
      edited.forEach((k,v) => {
        if (v != currentScores.entries.elementAt(index).value) {
          foundScores[index.toString()] = v
        },
        index++
      });
      return foundScores;
      //print(foundScores);
    }


  static Future<void> updatePlayerScore(int playerIndex, int Score, [ edit = false]) async {
    String playerPostion = "";
    int loadedScore = 0;
    int updatedScore = 0;

    playerPostion = Game._getPlayerIndex(playerIndex);


    if (edit) {
      DBHelper.update(
          'games', {playerPostion: Score}, 'Active = ?', ['Yes']);
    }
    else {
      loadedScore = await loadPlayerScore(playerIndex);
      updatedScore = loadedScore + Score;
      DBHelper.update(
          'games', {playerPostion: updatedScore}, 'Active = ?', ['Yes']);
    }
    debugPrint('update: $playerPostion :' + updatedScore.toString());
  }

  static Future<int> loadPlayerScore(int playerIndex) async {
    String playerPostion = "";
    List<Map<String, dynamic>> PlayerloadedScore = [];
    playerPostion = Game._getPlayerIndex(playerIndex);
    PlayerloadedScore = await DBHelper.getDataWhere(
        'games', [playerPostion], 'Active = ?', ['Yes']);
    debugPrint('loaded ' + PlayerloadedScore[0].entries.first.value.toString());
    return PlayerloadedScore[0].entries.first.value;
  }

  static Future<void> deleteGame(List gameids) async {
    DBHelper.delete('players', 'playername = ?', gameids);
  }
}
