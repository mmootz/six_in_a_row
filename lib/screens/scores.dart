
import 'package:flutter/material.dart';

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
    body: Text(Scores.toString()));
  }
}
