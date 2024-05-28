import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import '../data/playerData.dart';

class player {
  static Future<List> getPlayers() async {
    List loadedPlayers = [];
    final listPlayers = await playerData.getData('players');
    for (var element in listPlayers) {
      loadedPlayers.add(element['playername']);
    }

    return loadedPlayers;
  }

  static Future<String> addPlayer(String playername) async {
    int newID = 0;
    int testID = 0;
    if (playername.isEmpty) {
      return 'empty';
    } else if (playername.length >= 30) {
      return 'too_long';
    } else {
      bool alreadyExists = await playerData.checkExits(playername);
      if (alreadyExists) {
        return 'exists';
      } else {
        final getid = await playerData.getRawData(
            'SELECT MAX(id) FROM players');
        if (getid[0]['MAX(id)'] != null) {
          newID = getid[0]['MAX(id)'];
          newID++;
        }

        testID = await playerData.insert('players', {
          'id': newID,
          'playername': playername,
          'wins': 0,
          'losses': 0,
          'Highestscore': 0,
          'totalTwelves': 0,
          'totalscore': 0,
          'Gamesplayed': 0,
        });

        debugPrint(testID.toString());
      }
      return 'Created';
    }
  }

  static Future<void> deletePlayer(List playernames) async {
    playerData.delete('players', 'playername = ?', playernames);
  }

  static Future<List<Map<String, dynamic>>> getPlayerInfo(Player) async {
    List<Map<String, dynamic>> PlayerInfo = [];

    // get highest score
    // get games played
    // get win
    PlayerInfo = await playerData.getDataWhere(
        'players',
        ['wins', 'Highestscore', 'Gamesplayed', 'totalscore', 'losses'],
        'Playername = ?',
        [Player]);

    return PlayerInfo;
  }
}
