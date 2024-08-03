import 'package:flutter/material.dart';
import 'package:six/data/gameData.dart';
import 'package:six/data/playerData.dart';
import 'package:intl/intl.dart';

class Game {

  static Future<List> getGames() async {
    List foundGames = [];
    cleanUpGames(); // delete all games with None as winner
    final listPlayers = await gameData.getGames();
    for (var element in listPlayers) {
      foundGames.add(element['id'].toString());
    }
    return foundGames;
  }

  static Future<List> getWins(String player) async {
    List wins = [];

    wins = await gameData.getDataWhere(
        'games', ['Date', 'WinningScore'], 'Winner =?', [player]);
    return wins;
  }

  static Future<List> getPlayers(int gameId) async {
    List<Map<String, dynamic>> gamePlayers = [];
    gamePlayers = await gameData.getDataWhere(
        'games',
        [
          'FirstPlayer',
          'FirstPlayerScore',
          'SecondPlayer',
          'SecondPlayerScore',
          'ThirdPlayer',
          'ThirdPlayerScore',
          'FourthPlayer',
          'FourthPlayerScore'
        ],
        'id = ?',
        [gameId]);
    return gamePlayers;
  }

  static Future<List<Map<String, dynamic>>> getGameInfo(int gameId) async {
    List<Map<String, dynamic>> GameInfo = [];

    GameInfo = await gameData.getDataWhere(
        'games',
        ['id', 'Winner', 'WinningScore', 'LastRound', 'Date'],
        'id = ?',
        [gameId]);
    return GameInfo;
  }

  static Future<bool> checkHighScore(int score, String playerName,
      [gameFinished = false]) async {
    List<Map<String, dynamic>> getCurrentValue = [];

    getCurrentValue = await PlayerData.getDataWhere(
        'players', ['HighestScore'], 'PlayerName = ?', [playerName]);

    if (getCurrentValue[0]['HighestScore'] == 0 && gameFinished == false) {
      return false;
    }

    if (getCurrentValue[0]['HighestScore'] < score) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> updateRound(int round) async {
    gameData.update('games', {'LastRound': round}, 'Active = ?', ['Yes']);
  }

  static Future<void> updateHighScore(String playerName, int score) async {
    PlayerData.update(
        'players', {'HighestScore': score}, 'PlayerName = ?', [playerName]);
  }

  static Future<void> _updateTotalScore(String playerName, int score) async {
    List<Map<dynamic, dynamic>> getCurrentTotalScore = [];

    debugPrint('score:' + score.toString());
    debugPrint('PlayerName:' + playerName);

    getCurrentTotalScore = await PlayerData.getDataWhere(
        'players', ['TotalScore'], 'PlayerName = ?', [playerName]);
    debugPrint('TotalScore for: ' +
        playerName +
        ' ' +
        getCurrentTotalScore[0]['TotalScore'].toString());
    PlayerData.update(
        'players',
        {'TotalScore': getCurrentTotalScore[0]['TotalScore'] + score},
        'PlayerName = ?',
        [playerName]);
  }

  static Future<void> _incrementGame(String playerName) async {
    List<Map<String, dynamic>> getCurrentValue = [];

    getCurrentValue = await PlayerData.getDataWhere(
        'players', ['GamesPlayed'], 'PlayerName = ?', [playerName]);
    PlayerData.update(
        'players',
        {'GamesPlayed': getCurrentValue[0]['GamesPlayed'] + 1},
        'PlayerName = ?',
        [playerName]);
  }

  static Future<void> endGame(
      String winner, Map players, int winningScore) async {
    List<Map<String, dynamic>> getWins = [];
    List<Map<String, dynamic>> getLosses = [];
    List lost = [];
    final gameId =
        await gameData.getDataWhere('games', ['id'], 'Active = ?', ['Yes']);
    // make lost list
    players.forEach((k, v) => lost.add(k));
    lost.removeAt(0); // first one is winner

    // winner block
    getWins = await PlayerData.getDataWhere(
        'players', ['wins'], 'PlayerName = ?', [winner]);
    PlayerData.update('players', {'wins': getWins[0]['wins'] + 1},
        'PlayerName = ?', [winner]);
    _incrementGame(winner);
    gameData.update('games', {'Winner': winner, 'WinningScore': winningScore},
        'id = ?', [gameId[0]['id']]);

    // losers
    lost.forEach((index) async {
      getLosses = await PlayerData.getDataWhere(
          'players', ['losses'], 'playername = ?', [index]);
      PlayerData.update('players', {'losses': getLosses[0]['losses'] + 1},
          'playername = ?', [index]);
    });
    lost.forEach((index) {
      _incrementGame(index);
    });

    // update total scores for each player
    for (var playerMap in players.entries) {
      String playerName = playerMap.key;
      int playerScore = int.parse(playerMap.value);
      _updateTotalScore(playerName, playerScore);
    }
  }

  static _getPlayerIndex(int index) {
    String playerPosition = '';
    switch (index) {
      case 0:
        {
          playerPosition = 'FirstPlayerScore';
        }
        break;
      case 1:
        {
          playerPosition = 'SecondPlayerScore';
        }
        break;
      case 2:
        {
          playerPosition = 'ThirdPlayerScore';
        }
        break;
      case 3:
        {
          playerPosition = 'FourthPlayerScore';
        }
        break;
      default:
        {
          debugPrint('Invalid index number');
          playerPosition = 'ERROR';
        }
        break;
    }
    return playerPosition;
  }

  static Future<Map<String, String>> getScoresMAP(List players) async {
    //List foundGames = [];
    Map<String, String> scores = {};
    List<String> queryNamesList = [];
    List<String> queryScoresList = [];

    switch (players.length) {
      case 2:
        {
          queryNamesList = ['FirstPlayer', 'SecondPlayer'];
        }
        break;
      case 3:
        {
          queryNamesList = ['FirstPlayer', 'SecondPlayer', 'ThirdPlayer'];
        }
        break;
      case 4:
        {
          queryNamesList = [
            'FirstPlayer',
            'SecondPlayer',
            'ThirdPlayer',
            'FourthPlayer'
          ];
        }
        break;
      default:
        {
          debugPrint("Invalid length");
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
            'FourthPlayerScore'
          ];
        }
        break;
      default:
        {
          debugPrint("Invalid length");
        }
    }

    final queryNames = await gameData.getDataWhere(
        'games', queryNamesList, 'Active = ?', ['Yes']);

    final queryScores = await gameData.getDataWhere(
        'games', queryScoresList, 'Active = ?', ['Yes']);
    
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
          debugPrint("Invalid length");
        }
    }
    return scores;
  }

  static Future<List<Map<String, dynamic>>> getScoresSQL() async {
    final getCurrentScores =
        await gameData.getDataWhere('games', ['*'], 'Active = ?', ['Yes']);
    return getCurrentScores;
  }

  static Future<void> newGame(List playernames) async {
    String firstPlayer = playernames.first;
    String secondPlayer = playernames.elementAt(1);
    String thirdPlayer = "None"; // blank by default
    String fourthPlayer = "None"; // blank by default

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MMMEd');
    String formatted = formatter.format(now);
    
    // fill 3 and 4 players if they are present
    if (playernames.length == 3) {
      thirdPlayer = playernames.elementAt(2);
    }

    if (playernames.length == 4) {
      thirdPlayer = playernames.elementAt(2);
      fourthPlayer = playernames.elementAt(3);
    }
    int newID = 0;
    final getId = await gameData.getRawData('SELECT MAX(id) FROM games');
    if (getId[0]['MAX(id)'] != null) {
      newID = getId[0]['MAX(id)'];
      newID++;
    }

    // clear all other active games
    gameData.update('games', {'Active': 'no'}, 'Active = ?', ['Yes']);
    debugPrint('GameID: $newID');
    debugPrint('players: $playernames');
    gameData.insert('games', {
      'id': newID,
      'Active': 'Yes',
      'FirstPlayer': firstPlayer,
      'SecondPlayer': secondPlayer,
      'ThirdPlayer': thirdPlayer,
      'FourthPlayer': fourthPlayer,
      'FirstPlayerScore': 0,
      'SecondPlayerScore': 0,
      'ThirdPlayerScore': 0,
      'FourthPlayerScore': 0,
      'Date': formatted,
      'Winner' : 'None',
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

  static Future<void> updatePlayerScore(int playerIndex, int score,
      [edit = false]) async {
    String playerPosition = "";
    int loadedScore = 0;
    int updatedScore = 0;
    playerPosition = Game._getPlayerIndex(playerIndex);
    if (edit) {
      gameData.update('games', {playerPosition: score}, 'Active = ?', ['Yes']);
    } else {
      loadedScore = await loadPlayerScore(playerIndex);
      updatedScore = loadedScore + score;
      gameData.update(
          'games', {playerPosition: updatedScore}, 'Active = ?', ['Yes']);
    }
    debugPrint('update: $playerPosition :' + updatedScore.toString());
  }

  static Future<int> loadPlayerScore(int playerIndex) async {
    String playerPosition = "";
    List<Map<String, dynamic>> playerLoadedScore = [];
    playerPosition = Game._getPlayerIndex(playerIndex);
    playerLoadedScore = await gameData.getDataWhere(
        'games', [playerPosition], 'Active = ?', ['Yes']);
    return playerLoadedScore[0].entries.first.value;
  }

  static Future<void> cleanUpGames() async {
    // delete games with no score or winner if exited app or game
    gameData.delete('games', 'Winner = ?', ['None']);
    var test = await  gameData.getRawData('DELETE FROM games where Winner IS NULL');
    debugPrint(test.toString());
  }

  static Future<void> deleteGame() async {
    List currentGameId = [];
     currentGameId = await gameData.getDataWhere('games', ['id'], 'Active = ?', ['Yes']);
     gameData.delete('games', 'id = ?', [currentGameId[0]['id'].toString()]);
  }
}
