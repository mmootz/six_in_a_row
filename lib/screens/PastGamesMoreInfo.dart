import 'package:flutter/material.dart';
import 'package:six/widgets/gameMoreInfoPlayers.dart';

class PastGamesMoreInfo extends StatelessWidget {
  const PastGamesMoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameInfo =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        appBar: AppBar(
          title: const Text('More Info'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Game Id:' + gameInfo['id'].toString()),
            Text(gameInfo['Date']),
            Text('Rounds:' + gameInfo['LastRound'].toString()),
            Text('Winning Score:' + gameInfo['WinningScore'].toString()),
            Divider(thickness: 4.0),
            Container(
                height: 500,
                child: gameMoreInfoPlayers(gameInfo['id'], gameInfo['Winnner']))
          ],
        ));
  }
}
