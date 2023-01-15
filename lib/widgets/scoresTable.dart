import 'package:flutter/material.dart';

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
    int currentScore = widget.scores[playername] as int;
    int newScore = 0;
    newScore = currentScore + 1;
    debugPrint(newScore.toString());
    setState(() {
      widget.scores[playername] = newScore.toString();
    });
  }

  void sub(String playername) {
    int currentScore = widget.scores[playername] as int;
    int newScore = 0;
    newScore = currentScore - 1;
    debugPrint(newScore.toString());
    setState(() {
      widget.scores[playername] = newScore.toString();
    });
  }

  void updateScores() {
    // Game.updateGame({
    //   'FirstPlayerScore': widget.scores.entries.first.value,
    //   'SecondPlayerScore': widget.scores.entries.elementAt(1).value
    // });
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
                leading: widget.editMode
                    ? ElevatedButton(
                        onPressed: () => add(playername),
                        child: const Text('+'),
                      )
                    : SizedBox(
                        width: 1,
                        height: 1,
                      ),
                title: Text(
                  playername + ':' + playerscore,
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                trailing: widget.editMode
                    ? ElevatedButton(
                        child: Text('-'),
                        onPressed: () => sub(playername),
                      )
                    : SizedBox(
                        width: 1,
                        height: 1,
                      ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 2.0);
            },
          ),
        ),
        widget.editMode
            ? ElevatedButton(
                onPressed: () => updateScores(), child: Text('Update'))
            : Container()
      ],
    );
  }
}
