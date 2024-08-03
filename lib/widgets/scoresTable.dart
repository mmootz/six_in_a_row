import 'package:flutter/material.dart';
import 'package:six/data/games.dart';
import 'package:six/widgets/BottomButton.dart';

class ScoresTable extends StatefulWidget {
  //const ScoresTable({Key? key}) : super(key: key);

  final Map<String, String> scores;
  final bool editMode;

  const ScoresTable(this.scores, [this.editMode = false]);

  @override
  State<ScoresTable> createState() => _ScoresTableState();
}

class _ScoresTableState extends State<ScoresTable> {
  final List<int> colorCodes = <int>[600, 500, 100];

  sortScores(Map<String, String> players) {
    var sortedlist = players.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    players
      ..clear()
      ..addEntries(sortedlist);
    return players;
  }

  void add(String playerName) {
    int currentScore = int.parse(widget.scores[playerName]!);
    int newScore = 0;
    newScore = currentScore + 1;
    debugPrint(newScore.toString());
    setState(() {
      widget.scores[playerName] = newScore.toString();
    });
  }

  void sub(String playerName) {
    int currentScore = int.parse(widget.scores[playerName]!);
    int newScore = 0;
    newScore = currentScore - 1;
    debugPrint(newScore.toString());
    setState(() {
      widget.scores[playerName] = newScore.toString();
    });
  }

  Future<void> updateScores(Map<String, String> editedScores) async {
    List editPlayers = [];
    Map<String, String> currentScores = {};
    Map<String, String> updateTheseScores = {};
    // Game.updateGame({
    //   'FirstPlayerScore': widget.scores.entries.first.value,
    //   'SecondPlayerScore': widget.scores.entries.elementAt(1).value
    // });
    int index = 0;

    editedScores.forEach((k, v) => {editPlayers.add(k)});
    currentScores = await Game.getScoresMAP(editPlayers);
    updateTheseScores =
        await Game.findEditedScores(editedScores, currentScores);
    updateTheseScores.forEach((k, v) => {debugPrint('$index : $v'), index++});
    updateTheseScores.forEach((k, v) =>
        {Game.updatePlayerScore(int.parse(k), int.parse(v), true), index++});
    //editedScores.forEach((k,v) => {Game.updatePlayerScore(index, int.parse(v)), index++ } );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 6,
          margin: const EdgeInsets.all(10),
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: widget.scores.length,
            itemBuilder: (BuildContext context, int index) {
              String playerName = widget.scores.keys.elementAt(index);
              String playerScore = widget.scores[playerName].toString();
              return ListTile(
                leading: Text(playerName, style: const TextStyle(fontSize: 32)),
                // title: Text( ':',
                //   style: const TextStyle(fontSize: 32),
                //   textAlign: TextAlign.center,
                // ),
                trailing: widget.editMode
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => sub(playerName),
                            splashColor: Theme.of(context).primaryColor,
                          ),
                          Text(playerScore,
                              style: const TextStyle(fontSize: 32)),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => add(playerName),
                              splashColor: Theme.of(context).primaryColor),
                        ],
                      )
                    : Text(playerScore, style: const TextStyle(fontSize: 32)),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(thickness: 2.0);
            },
          ),
        ),
        widget.editMode
            ? BottomButton(text: 'Update', call:  () => updateScores(widget.scores))
            : Container()
      ],
    );
  }
}
