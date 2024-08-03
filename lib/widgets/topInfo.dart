import 'package:flutter/material.dart';


class TopInfo extends StatefulWidget {
  //const top_info({Key? key}) : super(key: key);

  @override
  State<TopInfo> createState() => _TopInfoState();
  final String currentPlayer;
  final int totalScore;
  final int roundNumber;
  final VoidCallback endGame;

  const TopInfo(
      {Key? key, required this.currentPlayer,
      required this.totalScore,
      required this.roundNumber,
      required this.endGame}) : super(key: key);
}

class _TopInfoState extends State<TopInfo> {
  bool clear = false;

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
              Text(" ${widget.currentPlayer} : ${widget.totalScore}"  ,
                  textAlign: TextAlign.left, style: const TextStyle(fontSize: 32)),
              Text("Round: ${widget.roundNumber}",
                  textAlign: TextAlign.right, style: const TextStyle(fontSize: 32))
            ],
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.05
          ),
        ]);
  }
}
