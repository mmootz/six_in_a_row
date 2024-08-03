import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import '../data/playerData.dart';

class Player {
  static Future<List> getPlayers() async {
    List loadedPlayers = [];
    final listPlayers = await PlayerData.getData('players');
    for (var element in listPlayers) {
      loadedPlayers.add(element['PlayerName']);
    }

    return loadedPlayers;
  }

  static Future<String> addPlayer(String playerName) async {
    int newID = 0;
    int testID = 0;
    if (playerName.isEmpty) {
      return 'empty';
    } else if (playerName.length >= 30) {
      return 'too_long';
    } else {
      bool alreadyExists = await PlayerData.checkExits(playerName);
      if (alreadyExists) {
        return 'exists';
      } else {
        final getId = await PlayerData.getRawData(
            'SELECT MAX(id) FROM players');
        if (getId[0]['MAX(id)'] != null) {
          newID = getId[0]['MAX(id)'];
          newID++;
        }

        testID = await PlayerData.insert('players', {
          'id': newID,
          'PlayerName': playerName,
          'wins': 0,
          'losses': 0,
          'HighestScore': 0,
          'totalTwelves': 0,
          'TotalScore': 0,
          'GamesPlayed': 0,
        });

        debugPrint(testID.toString());
      }
      return 'Created';
    }
  }

  static Future<void> deletePlayer(List playernames) async {
    PlayerData.delete('players', 'PlayerName = ?', playernames);
  }

  static Future<List<Map<String, dynamic>>> getPlayerInfo(Player) async {
    List<Map<String, dynamic>> playerInfo = [];

    // get highest score
    // get games played
    // get win
    playerInfo = await PlayerData.getDataWhere(
        'players',
        ['wins', 'HighestScore', 'GamesPlayed', 'TotalScore', 'losses'],
        'PlayerName = ?',
        [Player]);

    return playerInfo;
  }
}
