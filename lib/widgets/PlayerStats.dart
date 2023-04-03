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
    final List initLoadedStats = await player.getPlayerInfo(widget.PlayerName);
    if (initLoadedStats.isEmpty) {
      debugPrint('print');
    }
    debugPrint(initLoadedStats.toString());
    setState(() {
      loadedStats = initLoadedStats;
    });
    debugPrint("loaded state:" + loadedStats.toString());
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
          Text('Highest Score:' + loadedStats[0]['Highestscore'].toString()),
          // Text('Most twelves in a game: 6'),
          Text('Total Score:' + loadedStats[0]['Highestscore'].toString()),
          // Text('Total Twelves: 12'),
          Text('wins:' + loadedStats[0]['Wins'].toString()),
          Text('Losses:' + loadedStats[0]['Losses'].toString())
        ],
      );
    }
  }
}
