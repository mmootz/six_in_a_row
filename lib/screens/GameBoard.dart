import 'package:flutter/material.dart';
import '../widgets/GameButtons.dart';
import '../widgets/topInfo.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import '../widgets/SideBar.dart';
import 'package:six/data/games.dart';
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
  int _pageIndex = 0;

  @override
  void dispose() {
    KeepScreenOn.turnOff();
    super.dispose();
  }

  // this is void but it wouldn't let me call this as void?
  _selectPage(int index) {
    final loadPlayers = ModalRoute.of(context)?.settings.arguments as List;
    // nested it's not pretty
    if (index == 0) {
      if ( CurrentScore >0) {
        debugPrint('End round');
        EndRound(
            roundNumber: RoundNumber,
            currentPlayer: CurrentPlayer,
            currentScore: CurrentScore,
            players: loadPlayers,   // loads the players form init this doesn't change
            scores: Scores);
      }
    } else {
      debugPrint('End Game');
      if ( CurrentScore >0) {
        EndRound(
            roundNumber: RoundNumber,
            currentPlayer: CurrentPlayer,
            currentScore: CurrentScore,
            players: loadPlayers,
            // loads the players form init this doesn't change
            scores: Scores);
      }
      Navigator.pushNamed(context, 'WinScreen', arguments: Scores);
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
      /// maybe call scores.dart here?
      /// setup the map there and then handle all the data that way
      setState(() {
        CurrentPlayer = loadPlayers.first;
        Scores = loadPlayersIntoMap;
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
                onPressed: Clear,
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
                    endGame: Clear,
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
              BottomNavigationBarItem(icon: Icon(Icons.done), label: "End Turn"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_all), label: "End Game"),
            ],
          )),
    );
  }
}
