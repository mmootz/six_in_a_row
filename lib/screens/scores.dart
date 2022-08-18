
import 'package:flutter/material.dart';
import 'package:six/widgets/scoresTable.dart';
class Scores extends StatelessWidget {
  static const routeName = 'Scores';
  //const Scores({Key? key}) : super(key: key);

  // final String selectedPlayer;
  //
  // Scores(this.selectedPlayer);

  @override
  Widget build(BuildContext context) {
    final Scores =
    ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, int>;
    return Scaffold(
        appBar: AppBar(
        title: Text('Scores'),
    centerTitle: true,
    ),
    body: scoresTable(Scores));
  }
}
