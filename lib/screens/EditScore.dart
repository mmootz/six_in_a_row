
import 'package:flutter/material.dart';


import '../widgets/scoresTable.dart';

class editScore extends StatefulWidget {
  //const editScore({Key? key}) : super(key: key);
  static const routeName = 'Edit';

  @override
  State<editScore> createState() => _editScoreState();
}



SortScores(Map<String, int> players) {
  var sortedlist = players.entries.toList()
    ..sort((b, a) => a.value.compareTo(b.value));
  players
    ..clear()
    ..addEntries(sortedlist);
  return players;
}




class _editScoreState extends State<editScore> {
  Map<String, int>LoadedScores = {};

  // initloadedScore() async {
  //   Map<String, int>initLoadedScores = await Game.getScoresMAP();
  //   if (initLoadedScores.isEmpty) {
  //     debugPrint('print');
  //   }
  //   setState(() {
  //     LoadedScores = initLoadedScores;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     initloadedScore();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> LoadedScores = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // final Scores =
    // ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Scores'),
          centerTitle: true,
        ),
        body: scoresTable(LoadedScores, true));
  }
}
