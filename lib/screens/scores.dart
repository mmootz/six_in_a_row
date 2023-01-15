import 'package:flutter/material.dart';
import 'package:six/widgets/scoresTable.dart';

class Scores extends StatelessWidget {
  static const routeName = 'Scores';

  //const Scores({Key? key}) : super(key: key);

  // final String selectedPlayer;
  //
  // Scores(this.selectedPlayer);

  SortScores(Map<String, String> players) {
    var sortedlist = players.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    players
      ..clear()
      ..addEntries(sortedlist);
    return players;
  }

  @override
  Widget build(BuildContext context) {
    final Scores =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(
          title: Text('Scores'),
          centerTitle: true,
        ),
        body: scoresTable(SortScores(Scores)));
  }
}
