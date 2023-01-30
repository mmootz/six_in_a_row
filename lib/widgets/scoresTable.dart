import 'package:flutter/material.dart';
import 'package:six/data/games.dart';

class scoresTable extends StatefulWidget {
  //const scoresTable({Key? key}) : super(key: key);

  final Map<String, String> scores;
  final bool editMode;

  scoresTable(this.scores, [this.editMode = false]);

  @override
  State<scoresTable> createState() => _scoresTableState();
}

class _scoresTableState extends State<scoresTable> {
  final List<int> colorCodes = <int>[600, 500, 100];

  SortScores(Map<String, String> players) {
    var sortedlist = players.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    players
      ..clear()
      ..addEntries(sortedlist);
    return players;
  }

  void add(String playername) {
    int currentScore = int.parse(widget.scores[playername]!);
    int newScore = 0;
    newScore = currentScore + 1;
    debugPrint(newScore.toString());
    setState(() {
      widget.scores[playername] = newScore.toString();
    });
  }

  void sub(String playername) {
    int currentScore = int.parse(widget.scores[playername]!);
    int newScore = 0;
    newScore = currentScore - 1;
    debugPrint(newScore.toString());
    setState(() {
      widget.scores[playername] = newScore.toString();
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 6,
          margin: EdgeInsets.all(10),
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: widget.scores.length,
            itemBuilder: (BuildContext context, int index) {
              String playername = widget.scores.keys.elementAt(index);
              String playerscore = widget.scores[playername].toString();
              return ListTile(
                leading: Text(playername, style: const TextStyle(fontSize: 32)),
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
                            onPressed: () => sub(playername),
                            splashColor: Theme.of(context).primaryColor,
                          ),
                          Text(playerscore,
                              style: const TextStyle(fontSize: 32)),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => add(playername),
                              splashColor: Theme.of(context).primaryColor),
                        ],
                      )
                    : Text(playerscore, style: const TextStyle(fontSize: 32)),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 2.0);
            },
          ),
        ),
        widget.editMode
            ? Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 1,
                child: ElevatedButton(
                    onPressed: () => updateScores(widget.scores),
                    child: Text('Update')),
              )
            : Container()
      ],
    );
  }
}
