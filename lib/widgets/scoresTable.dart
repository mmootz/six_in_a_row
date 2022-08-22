import 'package:flutter/material.dart';

class scoresTable extends StatelessWidget {
  //const scoresTable({Key? key}) : super(key: key);

  final Map<String, int> scores;
  final List<int> colorCodes = <int>[600, 500, 100];

  scoresTable(this.scores);

  SortScores(Map<String, int> players) {
    var sortedlist = players.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    players
      ..clear()
      ..addEntries(sortedlist);
    return players;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        itemCount: scores.length,
        itemBuilder: (BuildContext context, int index) {
          String playername = scores.keys.elementAt(index);
          String playerscore = scores[playername].toString();
          return ListTile(
            title: Text(playername + ':' + playerscore,
            style: const TextStyle(fontSize: 32), textAlign: TextAlign.center,),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(thickness: 2.0);
        },),
    );
  }
}
