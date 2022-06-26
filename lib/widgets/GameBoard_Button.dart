import 'package:flutter/material.dart';

class GameBoard_Button extends StatelessWidget {
//  const GameBoard_Button({Key? key}) : super(key: key);

  final String ButtonText;
  final int ButtonValue;
  final Function ShortPress;

  GameBoard_Button(
      {required this.ButtonText, required this.ButtonValue, required this.ShortPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => ShortPress(ButtonValue * 2),
      onTap: () => ShortPress(ButtonValue),
      splashColor: Theme
          .of(context)
          .colorScheme
          .secondary,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Theme.of(context).colorScheme.primary,
        elevation: 6,
        margin: EdgeInsets.all(5),
        child: Container(
          width: 150,
          height: 45,
          child: Center(child: Text(ButtonText, style: TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}
