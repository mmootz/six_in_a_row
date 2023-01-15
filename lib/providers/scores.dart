import 'package:flutter/material.dart';

class ScoreProvider with ChangeNotifier {
  int value = 0;
  int total = 0;

  void increment(int add) {
    value += add;
    notifyListeners();
    totalScore(add);
  }

  void totalScore(int score, [bool loadScores = false]) {
    if (loadScores) {
      debugPrint('totalScore:' + score.toString());
      total = score;
      notifyListeners();
    } else {
      total += score;
      notifyListeners();
    }
  }

  void addScore(player, score) {}

  void clearScore() {
    total -= value;
    value = 0;
    notifyListeners();
  }

  updateScore(player, score) {}

  getScores() {
    // query db and get scores and return them as map
    Map<String, int> scoresMap = {};

    return scoresMap;
  }

  //this likely isn't useful'
  // void generateScoresMap(List Players)
  // {
  //   for (String player in Players) {
  //     scoresMap[player] = 0;
  //   }
  //   debugPrint("Generate scores" +  scoresMap.toString());
  //
  // }
  // load edited scores from database
  // or just modify them here?
  // depends on what makes more sense
  editScores() {}
}
