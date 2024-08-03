import 'package:flutter/material.dart';
import '../widgets/GameBoard_Button.dart';

class BottomButtons extends StatefulWidget {
  //const bottomButtons({Key? key}) : super(key: key);

  final Function addScore;
  const BottomButtons(this.addScore, {Key? key}) : super(key: key);

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GameBoardButton(
                    buttonText: "2",
                    buttonValue: 2,
                    shortPress: widget.addScore,
                    fireConfetti: false,
                  ),

                  GameBoardButton(
                    buttonText: "3",
                    buttonValue: 3,
                    shortPress: widget.addScore,
                    fireConfetti: false,
                  )

                  // SizedBox(
                  //   width: spacing,
                  // ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GameBoardButton(
                      buttonText: '4',
                      buttonValue: 4,
                      shortPress: widget.addScore,
                      fireConfetti: false,
                    ),
                    GameBoardButton(
                      buttonText: '5',
                      buttonValue: 5,
                      shortPress: widget.addScore,
                      fireConfetti: false,
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GameBoardButton(
                        buttonText: '6',
                        buttonValue: 6,
                        shortPress: widget.addScore,
                        fireConfetti: false),
                    GameBoardButton(
                      buttonText: '12',
                      buttonValue: 12,
                      shortPress: widget.addScore,
                      fireConfetti: true,
                    )
                  ]),
            ]));
  }
}
