
import 'package:flutter/material.dart';


import '../widgets/scoresTable.dart';

class EditScore extends StatefulWidget {
  const EditScore({Key? key}) : super(key: key);
  static const routeName = 'Edit';

  @override
  State<EditScore> createState() => _EditScoreState();
}

class _EditScoreState extends State<EditScore> {
  Map<String, int>loadedScores = {};

  @override
  Widget build(BuildContext context) {
    final Map<String, String> loadedScores = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Scores'),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          elevation: 6,
        ),
        body: ScoresTable(loadedScores, true));
  }
}
