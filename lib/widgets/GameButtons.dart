import 'package:flutter/material.dart';
import '../widgets/GameBoard_Button.dart';

class bottomButtons extends StatelessWidget {
  //const bottomButtons({Key? key}) : super(key: key);

  final Function addScore;

  bottomButtons(this.addScore);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GameBoard_Button(
                      ButtonText: "2", ButtonValue: 2, ShortPress: addScore),

                  GameBoard_Button(
                      ButtonText: "3", ButtonValue: 3, ShortPress: addScore)

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
                        ButtonText: '4', ButtonValue: 4, ShortPress: addScore),
                    GameBoard_Button(
                        ButtonText: '5', ButtonValue: 5, ShortPress: addScore),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GameBoard_Button(
                        ButtonText: '6', ButtonValue: 6, ShortPress: addScore),
                    // SizedBox(
                    //   width: spacing,
                    // ),
                    //GameBoard_Button(ButtonText: 'Clear', ButtonValue: 0, ShortPress: clearScore)
                    //GameBoard_Button(ButtonText: 'Clear', ButtonValue: 1, ShortPress: clearScore)
                    //ElevatedButton(onPressed: clearScore, child: Text('Clear')),
                    GameBoard_Button(
                        ButtonText: "12", ButtonValue: 12, ShortPress: addScore)
                  ]),
            ]));
  }
}
