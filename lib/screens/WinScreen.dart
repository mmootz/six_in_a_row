import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:six/data/games.dart';
import 'package:six/widgets/BottomButton.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WinScreen extends StatefulWidget {
  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  late ConfettiController confetti;
  var WinningScore = "";
  var WinningPlayer = "";

  @override
  void initState() {
    super.initState();
    confetti = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    confetti.dispose();
    super.dispose();
  }

  void shootConfetti() {
    confetti.play();
  }

  updateScores(Map players, winningPlayer, WinningScore) async {
    // get list of players
    // remove winning player from list
    // update winner score maybe finish game function
    // check each players highscore and update alert if doable
    // mark winner in db and everyone else as loss.
    // increment the games played by 1 for everyone

    //players.removeAt(0);
    Game.endGame(
      winningPlayer,
      players,
      WinningScore,
    );
  }

  void showMainMenu() {
    Navigator.popAndPushNamed(context, 'MainMenu');
  }

  findWinner(Map<String, String> players) {
    bool highscorecheck = false;
    var Winner = players.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    players
      ..clear()
      ..addEntries(Winner);

    setState(() {
      debugPrint(WinningPlayer);
      WinningPlayer = players.entries.first.key.toString();
      WinningScore = players.entries.first.value.toString();
    });
    // players.forEach((k, v) => playerList.add(k));
    // playerList.removeAt(0);
    updateScores(players, WinningPlayer, int.parse(WinningScore));
    players.forEach((player, score) async {
      highscorecheck =
          await Game.checkHighScore(int.parse(score), player, true);
      if (highscorecheck) {
        Game.updateHighScore(player, int.parse(score));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final players =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    findWinner(players);
    shootConfetti();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Six in a row'),
        centerTitle: true,
        elevation: 6,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(WinningPlayer,
              style: TextStyle(fontSize: 50), textAlign: TextAlign.center),
          Text(WinningScore,
                  style: TextStyle(fontSize: 50), textAlign: TextAlign.center)
              .animate()
              .fadeIn(duration: 2.seconds)
              .scale(duration: 1.seconds),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              alignment: Alignment(0.12, -0.3),
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.4,
                //   child: Image.asset(
                //     'lib/images/Trophy.png',
                //     fit: BoxFit.contain,
                //   ),
                // ),

                Align(
                  alignment: Alignment.centerRight,
                  child: ConfettiWidget(
                    confettiController: confetti,
                    blastDirectionality: BlastDirectionality.explosive,
                    blastDirection: pi,
                    maxBlastForce: 200,
                    numberOfParticles: 7,
                    emissionFrequency: 0.25,
                    gravity: 1,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.red,
                      Colors.green,
                      Colors.yellow
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConfettiWidget(
                    confettiController: confetti,
                    blastDirectionality: BlastDirectionality.explosive,
                    blastDirection: pi / 2,
                    maxBlastForce: 200,
                    numberOfParticles: 42,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.red,
                      Colors.green,
                      Colors.yellow
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    // padding: EdgeInsets.symmetric(vertical: 1.0),
                    itemCount: players.entries.length - 1,
                    itemBuilder: (context, index) {
                      final entry = players.entries.elementAt(index + 1);
                      return ListTile(
                        // contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                        leading:
                            Text(entry.key, style: TextStyle(fontSize: 32)),
                        trailing: Text(entry.value, style: TextStyle(fontSize: 32) ),
                        // title: Text(entry.key + ": " +  entry.value, textAlign: TextAlign.center) ,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          BottomButton(text: 'Main Menu', call: () => showMainMenu()),
        ],
      ),
    );
  }
}
