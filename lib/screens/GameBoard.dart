import 'package:flutter/material.dart';
import '../widgets/GameButtons.dart';
import '../widgets/topInfo.dart';

class GameBoard extends StatefulWidget {
  //const GameBoard({Key? key}) : super(key: key);
  static const routeName = 'GameBoard';

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Map<String, int> Scores = {};
  bool _loadedPlayers = false;
  int TotalScore = 0;
  int CurrentScore = 0;
  int RoundNumber = 1;
  String CurrentPlayer = "";

  _nextPlayer(List players, String currentPlayer) {
    String nxtPlayer = "";
    for (int i = 0; i < players.length; i++) {
      String match = "";
      int nextPlayerIndex = 0;
      match = players[i];
      if (currentPlayer == match) {
        // check if we will go out of bounds.
        nextPlayerIndex = i + 1;
        if (nextPlayerIndex >= players.length) {
          nxtPlayer = players[0];
        } else {
          nxtPlayer = players[nextPlayerIndex];
        }
      }
    }
    return nxtPlayer;
  }

  void AddScore(add) {
    setState(() {
      CurrentScore = CurrentScore + add as int;
    });
  }

  void Clear() {
    setState(() {
      CurrentScore = 0;
    });
  }

  updateScore(String player, int score, Map<String, int> scores) {
    int updatedScore = 0;
    int playerScore = scores[player] as int;
    updatedScore = playerScore + score;

    return updatedScore;
  }

  void EndRound(
      {required int currentScore,
      required String currentPlayer,
      required int roundNumber,
      required List players,
      required Map<String, int>? scores}) {

    var newScore = 0;
    var FindNextPlayer = "";

    newScore = updateScore(currentPlayer, currentScore, scores!);

    setState(() {
      scores[currentPlayer] = newScore;
    });


    FindNextPlayer = _nextPlayer(players, currentPlayer);
    if (FindNextPlayer == players.first) {
      // debugPrint(
      //     "player: $FindNextPlayer, Total score: $currentScore, round: ${roundNumber++} ");
      setState(() {
        RoundNumber++;
        CurrentPlayer = FindNextPlayer;
        TotalScore = scores[FindNextPlayer] as int;
      });
      Clear();
    } else {
      setState(() {
        CurrentPlayer = FindNextPlayer;
        TotalScore = scores[FindNextPlayer] as int;
      });
      Clear();
    }
  }

  @override
  void didChangeDependencies() {
    if (!_loadedPlayers) {
      final loadPlayers = ModalRoute.of(context)?.settings.arguments as List;
      final Map<String, int> loadPlayersIntoMap = {};

      for (String player in loadPlayers) {
        loadPlayersIntoMap[player] = 0;
      }

      setState(() {
        CurrentPlayer = loadPlayers.first;
        Scores = loadPlayersIntoMap;
      });
      _loadedPlayers = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final players = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
        appBar: AppBar(
          title: Text('Six in a row'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: Clear,
              icon: Icon(Icons.delete),
              tooltip: 'Clear score',
              splashColor: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                topInfo(
                    currentPlayer: CurrentPlayer,
                    totalScore: TotalScore,
                    currentScore: CurrentScore,
                    roundNumber: RoundNumber,
                    endGame: Clear),
                bottomButtons(AddScore),
                ElevatedButton(
                    onPressed: () => EndRound(
                        roundNumber: RoundNumber,
                        currentPlayer: CurrentPlayer,
                        currentScore: CurrentScore,
                        players: players,
                        scores: Scores),
                    child: Text('End Turn')),
                SizedBox(height: 100),

                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, 'WinScreen', arguments: Scores),
                    child: Text('End Game'))
              ],
            ),
          ),
        ));
  }
}
