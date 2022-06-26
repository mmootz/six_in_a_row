import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WinScreen extends StatelessWidget {
  //const WinScreen({Key? key}) : super(key: key);

  // final Map<String, int> Players;
  //
  // WinScreen(this.Players);

  findWinner(Map<String, int> players) {
    var WinningPlayer = "";
    var WinningScore = "";

    final findWinner = SplayTreeMap<String, int>.from(
        players, (value1, value2) => value1.compareTo(value2));
        WinningPlayer = findWinner.entries.first.key.toString();
        WinningScore = findWinner.entries.first.value.toString();
        findWinner.entries.skip(1);
    return "Winner is: $WinningPlayer, With $WinningScore Points!";
  }


  @override
  Widget build(BuildContext context) {
    final players = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, int>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Six in a row'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text(findWinner(players)),
              ElevatedButton(onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'MainMenu'),
                  child: Text('Main Menu'))
            ],
          ),
        ),)
      ,
    );
  }
}
