import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class GameBoard_Button extends StatefulWidget {
//  const GameBoard_Button({Key? key}) : super(key: key);

  final String ButtonText;
  final int ButtonValue;
  final Function ShortPress;
  bool fireConfetti;

  GameBoard_Button({required this.ButtonText,
    required this.ButtonValue,
    required this.ShortPress,
    required this.fireConfetti});

  @override
  State<GameBoard_Button> createState() => _GameBoard_ButtonState();
}

class _GameBoard_ButtonState extends State<GameBoard_Button> {
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
    widget.ShortPress(12);
  }

  sixcheck(buttonValue) {
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
        sixcheck(widget.ButtonValue) ? shootConfetti() : widget.ShortPress(
            widget.ButtonValue * 2),
        onTap: () =>
        widget.fireConfetti
            ? shootConfetti()
            : widget.ShortPress(widget.ButtonValue),
        splashColor: Theme
            .of(context)
            .colorScheme
            .secondary,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme
              .of(context)
              .colorScheme
              .primary,
          elevation: 6,
          margin: EdgeInsets.all(5),
          child: Container(
            width: 150,
            height: 45,
            child: Center(
                child: Text(
                  widget.ButtonText,
                  style: TextStyle(color: Colors.white),
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
