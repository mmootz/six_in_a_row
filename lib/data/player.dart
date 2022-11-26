
import '../data/playerData.dart';

class player {
  static Future<List> getPlayers() async {
    List loadedPlayers = [];
    final listPlayers = await DBHelper.getData('players');
    for (var element in listPlayers) {
      loadedPlayers.add(element['playername']);
    }

    return loadedPlayers;
  }
  static Future<void> addPlayer(String playername) async {
    int newID = 0;
    final getid = await DBHelper.getRawData('SELECT MAX(id) FROM players');
    if (getid[0]['MAX(id)'] != null) {
      newID = getid[0]['MAX(id)'];
      newID ++;
    }
    DBHelper.insert('players',
        {'id': newID, 'playername': playername, 'wins': 0, 'losses': 0});
  }

  static Future<void> deletePlayer(List playernames) async {
    DBHelper.delete('players', 'playername = ?', playernames );

  }
}
