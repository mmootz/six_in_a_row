import 'package:flutter/material.dart';

class Scores with ChangeNotifier {

  // Map<String, int> _scores = {};


  nextPlayer(List players, currentPlayer)
  {
    String player = "";
    for (int i = 0; i < players.length; i++) {
      String match = "";
      int nextPlayerIndex = 0;
      match = players[i];
      if (currentPlayer == match) {

        nextPlayerIndex = i + 1;
        if (nextPlayerIndex >= players.length) {
          player = players[0];
        } else {
          player = players[nextPlayerIndex];
        }
      }
    }
    return player;
  }

  currentScore()
  {
    return 'test' ;
  }


}