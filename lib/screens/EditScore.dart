
import 'package:flutter/material.dart';


import '../widgets/scoresTable.dart';

class editScore extends StatefulWidget {
  //const editScore({Key? key}) : super(key: key);
  static const routeName = 'Edit';

  @override
  State<editScore> createState() => _editScoreState();
}

class _editScoreState extends State<editScore> {
  Map<String, int>LoadedScores = {};

  @override
  Widget build(BuildContext context) {
    final Map<String, String> LoadedScores = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // final Scores =
    // ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Scores'),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: scoresTable(LoadedScores, true));
  }
}
