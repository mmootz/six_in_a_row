import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GameBoard.dart';
import 'package:six/widgets/getPlayers.dart';
import '../data/players.dart';
import 'package:six/widgets/playerCard.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List currentPlayers = [];

  _isSelected(player) {}

  void PlayersMangment(player) {
    // logic to check if player is already added
    // logic to check how many players in already added
    // maybe change Main Menu text?

    debugPrint(player);
    setState(() {
      currentPlayers.add(player);
    });
    //
    // setState(() {
    //   currentPlayers.add(player);
    // });
  }

  void _showGameboard(context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, GameBoard.routeName,
        arguments: currentPlayers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Six in a row'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text('Main Menu'),
              getPlayers(),

              // PlayerCard('Matt', '0', '1', PlayersMangment),
              // PlayerCard('Dad', '1', '0', PlayersMangment),
              // PlayerCard('Tom', '0', '1', PlayersMangment),
              // not sure why this doesn't work
              // Container(
              //   height: 300,
              //   child: GridView(
              //       //padding: EdgeInsets.all(20),
              //       children: PLAYERS
              //           .map((playerData) => PlayerCard(
              //               playerData.PlayerName,
              //               playerData.Wins.toString(),
              //               playerData.Losses.toString()))
              //           .toList(),
              //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //           maxCrossAxisExtent: 10,
              //           childAspectRatio: 2 / 2,
              //           crossAxisSpacing: 20,
              //           mainAxisSpacing: 20)),
              // ),
              ElevatedButton(
                  onPressed: () => _showGameboard(context),
                  child: Text('StartGame'))
            ],
          ),
        ),
      ),
    );
  }
}
