import 'package:flutter/material.dart';
import '../widgets/GameButtons.dart';
import '../widgets/topInfo.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:six/data/games.dart';
import 'package:six/widgets/BottomButton.dart';

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

  void ClearScore() {
    setState(() {
      CurrentScore = 0;
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
    bool newHighScore = false;
    var playerIndex = 0;
    int newTotalScore = 0;

    playerIndex = players.indexOf(currentPlayer);
    Game.updatePlayerScore(playerIndex, currentScore);
    newHighScore = await Game.checkHighScore(CurrentScore, CurrentPlayer);
    if (newHighScore) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('New HighScore!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ));
    }
    FindNextPlayer = _nextPlayer(players, currentPlayer);
    newTotalScore = await Game.loadPlayerScore(players.indexOf(FindNextPlayer));
    Scores = await Game.getScoresMAP(players);
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
    final loadPlayers = ModalRoute.of(context)?.settings.arguments as List;
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
                ClearScore();
              },
              icon: const Icon(Icons.delete),
              tooltip: 'Clear score',
              splashColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
        // this doesn't work in the sidebar widget because of context error
        // not sure how to pass it
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: double.infinity,
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.secondary,
                child: const Text(
                  'Options',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.score),
                  title: Text("Current Scores"),
                  onTap: () => {
                        Navigator.pop(context),
                        Navigator.pushNamed(context, 'Scores',
                            arguments: Scores)
                      }),
              ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Edit Scores"),
                  onTap: () => {
                        Navigator.pop(context),
                        Navigator.pushNamed(context, 'Edit', arguments: Scores)
                      }),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Clear Score"),
                onTap: ClearScore,
              ),
              ListTile(
                  leading: Icon(Icons.clear),
                  title: Text("Quit Game"),
                  onTap: () => {
                        Navigator.pop(context),
                        debugPrint(context.toString()),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Quit'),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            action: SnackBarAction(
                              label: 'Okay',
                              textColor: Theme.of(context).canvasColor,
                              onPressed: () =>
                                  Navigator.pushNamed(context, 'MainMenu'),
                            )))
                      }),
              ListTile(
                  leading: Icon(Icons.done_all),
                  title: Text("End Game"),
                  onTap: () => {
                        Navigator.pop(context),
                        debugPrint(context.toString()),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('End Game?'),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            action: SnackBarAction(
                              label: 'Yes',
                              textColor: Theme.of(context).canvasColor,
                              onPressed: () => Navigator.pushNamed(
                                  context, 'WinScreen',
                                  arguments: Scores),
                            )))
                      }
                  // Navigator.pushNamed(context, 'WinScreen', arguments: Scores )),
                  )
            ],
          ),
        ),
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
                BottomButton(
                    text: 'End Turn',
                    call: () => EndRound(
                        roundNumber: RoundNumber,
                        currentPlayer: CurrentPlayer,
                        currentScore: CurrentScore,
                        players: loadPlayers,
                        // loads the players form init this doesn't change
                        scores: Scores))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
