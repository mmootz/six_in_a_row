import 'package:flutter/material.dart';
import '../widgets/GameBoard_Button.dart';

class bottomButtons extends StatefulWidget {
  //const bottomButtons({Key? key}) : super(key: key);

  final Function addScore;
  bottomButtons(this.addScore);

  @override
  State<bottomButtons> createState() => _bottomButtonsState();
}

class _bottomButtonsState extends State<bottomButtons> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GameBoard_Button(
                    ButtonText: "2",
                    ButtonValue: 2,
                    ShortPress: widget.addScore,
                    fireConfetti: false,
                  ),

                  GameBoard_Button(
                    ButtonText: "3",
                    ButtonValue: 3,
                    ShortPress: widget.addScore,
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
                    GameBoard_Button(
                      ButtonText: '4',
                      ButtonValue: 4,
                      ShortPress: widget.addScore,
                      fireConfetti: false,
                    ),
                    GameBoard_Button(
                      ButtonText: '5',
                      ButtonValue: 5,
                      ShortPress: widget.addScore,
                      fireConfetti: false,
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GameBoard_Button(
                        ButtonText: '6',
                        ButtonValue: 6,
                        ShortPress: widget.addScore,
                        fireConfetti: false),
                    GameBoard_Button(
                      ButtonText: '12',
                      ButtonValue: 12,
                      ShortPress: widget.addScore,
                      fireConfetti: true,
                    )
                  ]),
            ]));
  }
}
