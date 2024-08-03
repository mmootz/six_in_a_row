import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class GameBoardButton extends StatefulWidget {
//  const GameBoard_Button({Key? key}) : super(key: key);

  final String buttonText;
  final int buttonValue;
  final Function shortPress;
  bool fireConfetti;

  GameBoardButton({Key? key, required this.buttonText,
    required this.buttonValue,
    required this.shortPress,
    required this.fireConfetti}) : super(key: key);

  @override
  State<GameBoardButton> createState() => _GameBoardButtonState();
}

class _GameBoardButtonState extends State<GameBoardButton> {
  late ConfettiController confetti;

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
    widget.shortPress(12);
  }

  sixCheck(buttonValue) {
    if (buttonValue == 6) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onLongPress: () =>
        sixCheck(widget.buttonValue) ? shootConfetti() : widget.shortPress(
            widget.buttonValue * 2),
        onTap: () =>
        widget.fireConfetti
            ? shootConfetti()
            : widget.shortPress(widget.buttonValue),
        splashColor: Theme
            .of(context)
            .colorScheme
            .secondary,
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 6,
          margin: const EdgeInsets.all(5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Center(
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
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
    ]
    );
  }
}
