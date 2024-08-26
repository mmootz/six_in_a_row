import 'package:flutter/material.dart';
import '../widgets/GameButtons.dart';
import '../widgets/topInfo.dart';
import 'package:six/data/games.dart';
import 'package:six/widgets/BottomButton.dart';
import 'package:keep_screen_on/keep_screen_on.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);
  static const routeName = 'GameBoard';

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Map<String, String> Scores = {};
  bool _loadedPlayers = false;
  int totalScore = 0;
  int currentScore = 0;
  int roundNumber = 1;
  String currentPlayer = "";

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

  void quitGame() {
    // error on quit game?
    //
    Game.deleteGame();
    Navigator.pushNamed(context, 'MainMenu');
  }

  void endGame() {
    // try pop and push named here. to get rid of back arrow.
    //Navigator.pushNamed(context, 'WinScreen', arguments: Scores);

    //Navigator.popAndPushNamed(context, 'WinScreen', arguments: Scores);
    //Navigator.pushReplacementNamed(context, 'WinScreen', arguments: Scores);
    Navigator.pushNamedAndRemoveUntil(
        context, 'WinScreen', (Route<dynamic> route) => false,
        arguments: Scores);
  }

  void addScore(add) {
    setState(() {
      currentScore = currentScore + add as int;
    });
  }

  void clearScore() {
    setState(() {
      currentScore = 0;
    });
  }

  void shootConfetti() {
    debugPrint('fire');
  }

  Future<void> endRound(
      {required int currentScoreEndRound,
      required String currentPlayerEndRound,
      required int roundNumberEndRound,
      required List players,
      required Map<String, String>? scores}) async {
    var findNextPlayer = "";
    bool newHighScore = false;
    var playerIndex = 0;
    int newTotalScore = 0;

    if (currentScoreEndRound >= 100) {
      clearScore();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Score Too High!'),
        backgroundColor: Theme.of(context).primaryColor
      ));
    } else {
      playerIndex = players.indexOf(currentPlayerEndRound);
      Game.updatePlayerScore(playerIndex, currentScoreEndRound);
    }

    newHighScore = await Game.checkHighScore(currentScore, currentPlayer);
    if (newHighScore) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('New HighScore!'),
        backgroundColor: Theme.of(context).primaryColor
      ));
    }
    findNextPlayer = _nextPlayer(players, currentPlayerEndRound);
    newTotalScore = await Game.loadPlayerScore(players.indexOf(findNextPlayer));
    Scores = await Game.getScoresMAP(players);

    if (findNextPlayer == players.first) {
      setState(() {
        roundNumber++;
        currentPlayer = findNextPlayer;
        currentScore = 0;
        totalScore = newTotalScore;
      });
      debugPrint('updateRound');
      Game.updateRound(roundNumber);
      //ScoreProvider().clearScore();
    } else {
      setState(() {
        currentPlayer = findNextPlayer;
        currentScore = 0;
        totalScore = newTotalScore;
      });
      //ScoreProvider().clearScore();
    }
  }

  @override
  void didChangeDependencies() {
    if (!_loadedPlayers) {
      final loadPlayers = ModalRoute.of(context)?.settings.arguments as List;
      Map<String, int> loadPlayersIntoMap = {};
      for (String player in loadPlayers) {
        loadPlayersIntoMap[player] = 0;
      }

      /// setup the map there and then handle all the data that way
      setState(() {
        currentPlayer = loadPlayers.first;
      });

      Game.newGame(loadPlayers);
      _loadedPlayers = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadPlayers = ModalRoute.of(context)?.settings.arguments as List;
    bool shouldPop = false;
    // This keeps the screen on during the scoring
    KeepScreenOn.turnOn();
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Six'),
          centerTitle: true,
          elevation: 6,
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
                color: Theme.of(context).primaryColor,
                child: const Text(
                  'Options',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.score),
                  title: const Text("Current Scores"),
                  onTap: () => {
                        Navigator.pop(context),
                        Navigator.pushNamed(context, 'Scores',
                            arguments: Scores)
                      }),
              ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text("Edit Scores"),
                  onTap: () => {
                        Navigator.pop(context),
                        Navigator.pushNamed(context, 'Edit', arguments: Scores)
                      }),
              ListTile(
                  leading: const Icon(Icons.swap_vert_rounded),
                  title: const Text("Swap Tile"),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Swap Tile?'),
                            content:
                            const Text("Do you want to swap a tile for zero points?"),
                            actions: [
                              TextButton(
                                  onPressed: () => {
                                    Navigator.of(context).pop(),
                                    endRound(currentScoreEndRound: 0,
                                        currentPlayerEndRound: currentPlayer,
                                        roundNumberEndRound: roundNumber,
                                        players: loadPlayers,
                                        scores: Scores),
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  child: const Text('No'))
                            ],
                          );
                        }),

                  },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Clear Score"),
                onTap: clearScore,
              ),
              ListTile(
                  leading: const Icon(Icons.clear),
                  title: const Text("Quit Game"),
                  onTap: () => {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Quit game?'),
                                content:
                                    const Text("Do you want to quit the game?"),
                                actions: [
                                  TextButton(
                                      onPressed: () => {
                                            Navigator.of(context).pop(),
                                            quitGame()
                                          },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('No'))
                                ],
                              );
                            })
                      }),
              ListTile(
                  leading: const Icon(Icons.done_all),
                  title: const Text("End Game"),
                  onTap: () => {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('End game?'),
                                content:
                                    const Text("Do you want to end the game?"),
                                actions: [
                                  TextButton(
                                      onPressed: () => {
                                            Navigator.of(context).pop(),
                                            endGame(),
                                          },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('No'))
                                ],
                              );
                            })
                      })
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              children: [
                TopInfo(
                  currentPlayer: currentPlayer,
                  totalScore: totalScore,
                  roundNumber: roundNumber,
                  endGame: () => debugPrint('Null for some reason'),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: clearScore,
                  child: Text(
                    currentScore.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 75),
                  ),
                ),
                BottomButtons(addScore),
                BottomButton(
                    text: 'End Turn',
                    call: () => endRound(
                        roundNumberEndRound: roundNumber,
                        currentPlayerEndRound: currentPlayer,
                        currentScoreEndRound: currentScore,
                        players: loadPlayers,
                        scores: Scores))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
