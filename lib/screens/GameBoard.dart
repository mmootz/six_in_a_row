
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/GameButtons.dart';
import '../widgets/topInfo.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import '../widgets/SideBar.dart';
import 'package:six/data/games.dart';
import 'package:six/providers/scores.dart';

// need to pop call back to reload scores again?
// not sure if you can do that but will need to trigger a reload after scores change.

class GameBoard extends StatefulWidget {
  //const GameBoard({Key? key}) : super(key: key);
  static const routeName = 'GameBoard';

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Map<String, String> Scores = {};
  bool _loadedPlayers = false;
  int TotalScore = 0;
  int CurrentScore = 0;
  int RoundNumber = 1;
  String CurrentPlayer = "";
  int _pageIndex = 0;
  int gameId = 0;

  @override
  void dispose() {
    KeepScreenOn.turnOff();
    super.dispose();
  }

  // this is void but it wouldn't let me call this as void?
  _selectPage(int index) async {
    final loadPlayers = ModalRoute.of(context)?.settings.arguments as List;
    // nested it's not pretty
    if (index == 0) {
      if (CurrentScore > 0) {
        debugPrint('End round');
        EndRound(
            roundNumber: RoundNumber,
            currentPlayer: CurrentPlayer,
            currentScore: CurrentScore,
            players: loadPlayers,
            // loads the players form init this doesn't change
            scores: Scores);
      }
    } else {
      debugPrint('End Game');
      // if (CurrentScore > 0) {
      //   EndRound(
      //       roundNumber: RoundNumber,
      //       currentPlayer: CurrentPlayer,
      //       currentScore: CurrentScore,
      //       players: loadPlayers,
      //       // loads the players form init this doesn't change
      //       scores: Scores);
      // }
      Scores = await Game.getScoresMAP(loadPlayers);
      Navigator.pushNamed(context, 'Scores', arguments: Scores);
      //Navigator.pushNamed(context, 'WinScreen', arguments: Scores);
      // Navigator.pushNamed(context, 'Scores',
      //     arguments: Scores);
    }
    setState(() {
      _pageIndex = index;
    });
  }

  _nextPlayer(List players, String currentPlayer) {
    // Find the next player by going though the list of players
    // if at last player return the first player
    String nxtPlayer = "";
    for (int i = 0; i < players.length; i++) {
      String match = "";
      int nextPlayerIndex = 0;
      match = players[i];
      if (currentPlayer == match) {
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

  void shootConfetti() {
    debugPrint('fire');
  }
  Future<void> EndRound(
      {required int currentScore,
      required String currentPlayer,
      required int roundNumber,
      required List players,
      required Map<String, String>? scores}) async {
    var FindNextPlayer = "";
    var playerIndex = 0;
    int newTotalScore = 0;

    playerIndex = players.indexOf(currentPlayer);
    Game.updatePlayerScore(playerIndex, currentScore );
    FindNextPlayer = _nextPlayer(players, currentPlayer);
    newTotalScore = await Game.loadPlayerScore(players.indexOf(FindNextPlayer));
    scores = await Game.getScoresMAP(players);
    //ScoreProvider().totalScore(newTotalScore, true);
    if (FindNextPlayer == players.first) {
      // debugPrint(1
      //     "player: $FindNextPlayer, Total score: $currentScore, round: ${roundNumber++} ");
      setState(() {
        RoundNumber++;
        CurrentPlayer = FindNextPlayer;
        CurrentScore = 0;
        TotalScore = newTotalScore;
      });
      //ScoreProvider().clearScore();
    } else {
      setState(() {
        CurrentPlayer = FindNextPlayer;
        CurrentScore = 0;
        TotalScore = newTotalScore;
      });
      //ScoreProvider().clearScore();
    }
  }

  @override
  void didChangeDependencies() {
    if (!_loadedPlayers) {
      final loadPlayers = ModalRoute.of(context)?.settings.arguments as List;
      Map<String, int> loadPlayersIntoMap = {};
      //ScoreProvider().generateScoresMap(loadPlayers);
      for (String player in loadPlayers) {
        loadPlayersIntoMap[player] = 0;
      }

      /// maybe call scores.dart here?
      /// setup the map there and then handle all the data that way
      setState(() {
        CurrentPlayer = loadPlayers.first;
        //Scores = ScoreProvider().getScores();
      });

      Game.newGame(loadPlayers);
      _loadedPlayers = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This keeps the screen on during the scoring
    bool shouldPop = false;
    KeepScreenOn.turnOn();
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Six in a row'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  var score = context.read<ScoreProvider>();
                  score.clearScore();
                },
                icon: const Icon(Icons.delete),
                tooltip: 'Clear score',
                splashColor: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          drawer: SideBar(Scores),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Column(
                children: [
                  topInfo(
                    currentPlayer: CurrentPlayer,
                    totalScore: TotalScore,
                    currentScore: CurrentScore,
                    roundNumber: RoundNumber,
                    endGame: () => debugPrint('Null for some reason'),
                  ),
                  //const SizedBox(height: 150),
                  bottomButtons(AddScore),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), label: "End Turn"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.score), label: "Scores"),
            ],
          )),
    );
  }
}
