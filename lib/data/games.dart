import 'package:flutter/material.dart';
import 'package:six/data/gamesData.dart';
import 'package:six/data/playerData.dart';
import 'package:intl/intl.dart';

class Game {

  static Future<List> getGames() async {
    List foundGames = [];
    cleanUpGames(); // delete all games with None as winner
    final listPlayers = await DBHelper.getGames();
    for (var element in listPlayers) {
      foundGames.add(element['id'].toString());
    }
    return foundGames;
  }

  static Future<List> getWins(String player) async {
    List wins = [];

    wins = await DBHelper.getDataWhere(
        'games', ['Date', 'WinningScore'], 'Winnner =?', [player]);
    return wins;
  }

  static Future<List> getPlayers(int gameId) async {
    List<Map<String, dynamic>> gamePlayers = [];
    gamePlayers = await DBHelper.getDataWhere(
        'games',
        [
          'FirstPlayer',
          'FirstPlayerScore',
          'SecondPlayer',
          'SecondPlayerScore',
          'ThirdPlayer',
          'ThirdPlayerScore',
          'ForthPlayer',
          'ForthPlayerScore'
        ],
        'id = ?',
        [gameId]);
    return gamePlayers;
  }

  static Future<List<Map<String, dynamic>>> getGameInfo(int gameId) async {
    List<Map<String, dynamic>> GameInfo = [];

    GameInfo = await DBHelper.getDataWhere(
        'games',
        ['id', 'Winnner', 'WinningScore', 'LastRound', 'Date'],
        'id = ?',
        [gameId]);
    return GameInfo;
  }

  static Future<bool> checkHighScore(int Score, String playername,
      [gameFinished = false]) async {
    List<Map<String, dynamic>> getCurrentValue = [];

    getCurrentValue = await playerData.getDataWhere(
        'players', ['Highestscore'], 'playername = ?', [playername]);

    if (getCurrentValue[0]['Highestscore'] == 0 && gameFinished == false) {
      return false;
    }

    if (getCurrentValue[0]['Highestscore'] < Score) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> updateRound(int round) async {
    DBHelper.update('games', {'LastRound': round}, 'Active = ?', ['Yes']);
  }

  static Future<void> updateHighScore(String playername, int score) async {
    playerData.update(
        'players', {'Highestscore': score}, 'playername = ?', [playername]);
  }

  static Future<void> _updatetotalscore(String playername, int score) async {
    List<Map<dynamic, dynamic>> getCurrentTotalScore = [];

    debugPrint('score:' + score.toString());
    debugPrint('playername:' + playername);

    getCurrentTotalScore = await playerData.getDataWhere(
        'players', ['totalscore'], 'playername = ?', [playername]);
    debugPrint('totalscore for: ' +
        playername +
        ' ' +
        getCurrentTotalScore[0]['totalscore'].toString());
    playerData.update(
        'players',
        {'totalscore': getCurrentTotalScore[0]['totalscore'] + score},
        'playername = ?',
        [playername]);
  }

  static Future<void> _incrementGame(String playername) async {
    List<Map<String, dynamic>> getCurrentValue = [];

    getCurrentValue = await playerData.getDataWhere(
        'players', ['Gamesplayed'], 'playername = ?', [playername]);
    playerData.update(
        'players',
        {'Gamesplayed': getCurrentValue[0]['Gamesplayed'] + 1},
        'playername = ?',
        [playername]);
  }

  static Future<void> endGame(
      String winner, Map players, int winningScore) async {
    List<Map<String, dynamic>> getWins = [];
    List<Map<String, dynamic>> getlosses = [];
    List lost = [];
    final gameId =
        await DBHelper.getDataWhere('games', ['id'], 'Active = ?', ['Yes']);
    // make lost list
    players.forEach((k, v) => lost.add(k));
    lost.removeAt(0); // first one is winner

    // winner block
    getWins = await playerData.getDataWhere(
        'players', ['wins'], 'playername = ?', [winner]);
    playerData.update('players', {'wins': getWins[0]['wins'] + 1},
        'playername = ?', [winner]);
    _incrementGame(winner);
    DBHelper.update('games', {'Winnner': winner, 'WinningScore': winningScore},
        'id = ?', [gameId[0]['id']]);

    // losers
    lost.forEach((index) async {
      getlosses = await playerData.getDataWhere(
          'players', ['losses'], 'playername = ?', [index]);
      playerData.update('players', {'losses': getlosses[0]['losses'] + 1},
          'playername = ?', [index]);
    });
    lost.forEach((index) {
      _incrementGame(index);
    });

    // update total scores for each player
    for (var playermap in players.entries) {
      String playername = playermap.key;
      int playerscore = int.parse(playermap.value);
      _updatetotalscore(playername, playerscore);
    }
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
          queryScoresList = [
            'FirstPlayerScore',
            'SecondPlayerScore',
            'ThirdPlayerScore'
          ];
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

    final queryNames = await DBHelper.getDataWhere(
        'games', queryNamesList, 'Active = ?', ['Yes']);

    final queryScores = await DBHelper.getDataWhere(
        'games', queryScoresList, 'Active = ?', ['Yes']);

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
          debugPrint(queryScores.toString());
          scores[queryNames[0].entries.first.value.toString()] =
              queryScores[0].entries.first.value.toString();
          scores[queryNames[0].entries.elementAt(1).value.toString()] =
              queryScores[0].entries.elementAt(1).value.toString();
          scores[queryNames[0].entries.elementAt(2).value.toString()] =
              queryScores[0].entries.elementAt(2).value.toString();
          scores[queryNames[0].entries.elementAt(3).value.toString()] =
              queryScores[0].entries.elementAt(3).value.toString();
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

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MMMEd');
    String formatted = formatter.format(now);
    //DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);

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
    debugPrint('GameID: $newID');
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
      'Date': formatted,
      'Winnner' : 'None',
      'WinningScore' : 0
    });
  }

  static Future<Map<String, String>> findEditedScores(
      Map<String, String> edited, Map<String, String> currentScores) async {
    // take in the map from the edited page and compare it to what is in database
    // find the diff and get the index for each.
    // update score with the new index.

    //edited(Map currentScores, Map editedScores ) {
    Map<String, String> foundScores = {};
    int index = 0;
    edited.forEach((k, v) => {
          if (v != currentScores.entries.elementAt(index).value)
            {foundScores[index.toString()] = v},
          index++
        });
    return foundScores;
  }

  static Future<void> updatePlayerScore(int playerIndex, int Score,
      [edit = false]) async {
    String playerPostion = "";
    int loadedScore = 0;
    int updatedScore = 0;

    playerPostion = Game._getPlayerIndex(playerIndex);

    if (edit) {
      DBHelper.update('games', {playerPostion: Score}, 'Active = ?', ['Yes']);
    } else {
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
    return PlayerloadedScore[0].entries.first.value;
  }

  static Future<void> cleanUpGames() async {
    // delete names with no score or winner if exited app or game
    DBHelper.delete('games', 'Winnner = ?', ['None']);
    var test = await  DBHelper.getRawData('DELETE FROM games where Winnner IS NULL');

    debugPrint(test.toString());
  }


  static Future<void> deleteGame() async {
    List currentGameId = [];
     currentGameId = await DBHelper.getDataWhere('games', ['id'], 'Active = ?', ['Yes']);
     DBHelper.delete('games', 'id = ?', [currentGameId[0]['id'].toString()]);


  }
}
