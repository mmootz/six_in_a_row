import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:six/data/games.dart';
import 'package:six/widgets/BottomButton.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({Key? key}) : super(key: key);

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  late ConfettiController confetti;
  var winningScore = "";
  var winningPlayer = "";

  @override
  void initState() {
    super.initState();
    confetti = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    confetti.dispose();
    super.dispose();
  }

  void shootConfetti() {
    confetti.play();
  }

  updateScores(Map players, winningPlayer, winningScore) async {
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
      winningScore,
    );
  }

  void showMainMenu() {
    Navigator.popAndPushNamed(context, 'MainMenu');
  }

  findWinner(Map<String, String> players) {
    bool highScoreCheck = false;
    var winner = players.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    players
      ..clear()
      ..addEntries(winner);

    setState(() {
      debugPrint(winningPlayer);
      winningPlayer = players.entries.first.key.toString();
      winningScore = players.entries.first.value.toString();
    });
    // players.forEach((k, v) => playerList.add(k));
    // playerList.removeAt(0);
    updateScores(players, winningPlayer, int.parse(winningScore));
    players.forEach((player, score) async {
      highScoreCheck =
          await Game.checkHighScore(int.parse(score), player, true);
      if (highScoreCheck) {
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
        title: const Text('Six in a row'),
        centerTitle: true,
        elevation: 6,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(winningPlayer,
                  style: const TextStyle(fontSize: 50), textAlign: TextAlign.center)
              .animate()
              .fadeIn(duration: 1.seconds)
              .scale(duration: 1.seconds),
          Text(winningScore,
                  style: const TextStyle(fontSize: 50), textAlign: TextAlign.center)
              .animate()
              .fadeIn(duration: 2.seconds)
              .scale(duration: 2.seconds),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              alignment: const Alignment(0.12, -0.3),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    // padding: EdgeInsets.symmetric(vertical: 1.0),
                    itemCount: players.entries.length - 1,
                    itemBuilder: (context, index) {
                      final entry = players.entries.elementAt(index + 1);
                      return ListTile(
                        // contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                        leading:
                            Text(entry.key, style: const TextStyle(fontSize: 32)).animate().fadeIn(duration: 3.seconds).scale(duration: 3.seconds),
                        trailing:
                            Text(entry.value, style: const TextStyle(fontSize: 32)).animate().fadeIn(duration: 3.seconds).scale(duration: 3.seconds),
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
