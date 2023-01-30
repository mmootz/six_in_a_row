import 'package:flutter/material.dart';


class topInfo extends StatefulWidget {
  //const top_info({Key? key}) : super(key: key);

  @override
  State<topInfo> createState() => _topInfoState();
  final String currentPlayer;
  final int totalScore;
  final int currentScore;
  final int roundNumber;
  final VoidCallback endGame;

  topInfo(
      {required this.currentPlayer,
      required this.totalScore,
      required this.currentScore,
      required this.roundNumber,
      required this.endGame});
}

class _topInfoState extends State<topInfo> {
  bool gameOver = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.currentPlayer,
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 32)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Score: ${widget.totalScore}",
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 32)),
              Text("Round: ${widget.roundNumber}",
                  textAlign: TextAlign.right, style: TextStyle(fontSize: 32)),
            ],
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.05
          ),
          Text(
            widget.currentScore.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 75),
          ),
          // Container(
          //     height: MediaQuery.of(context).size.height * 0.09
          // )
          // Consumer<ScoreProvider>(
          //   builder: (context, ScoreProvider, child) => Text(
          //     //widget.currentScore.toString(),
          //     '${ScoreProvider.value}',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 32),
          //   ),
          // ),
        ]);
  }
}
