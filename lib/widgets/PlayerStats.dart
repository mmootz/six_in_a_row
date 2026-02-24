import 'package:flutter/material.dart';
import 'package:six/data/player.dart';

class playerStats extends StatefulWidget {
  //const playerStats({Key? key}) : super(key: key);
  final String PlayerName;

  playerStats(this.PlayerName);

  @override
  State<playerStats> createState() => _playerStatsState();
}

class _playerStatsState extends State<playerStats> {
  List loadedStats = [];

  initloadedStats() async {
    final List initLoadedStats = await Player.getPlayerInfo(widget.PlayerName);
    if (initLoadedStats.isEmpty) {
      debugPrint('Player data is empty');
    }
    debugPrint('Raw data: $initLoadedStats');
    if (initLoadedStats.isNotEmpty) {
      debugPrint('Keys in data: ${initLoadedStats[0].keys}');
      debugPrint('HighestScore: ${initLoadedStats[0]['HighestScore']}');
      debugPrint('TotalScore: ${initLoadedStats[0]['TotalScore']}');
    }
    setState(() {
      loadedStats = initLoadedStats;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initloadedStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadedStats.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Highest Score:' + loadedStats[0]['HighestScore'].toString()),
          Text('Total Score:' + loadedStats[0]['TotalScore'].toString()),
          Text('wins:' + loadedStats[0]['wins'].toString()),
          Text('Losses:' + loadedStats[0]['losses'].toString())
        ],
      );
    }
  }
}
