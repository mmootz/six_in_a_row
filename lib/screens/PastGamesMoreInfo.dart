
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
          elevation: 6,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Game Id:' + gameInfo['id'].toString()),
            Text(gameInfo['Date']),
            Text('Rounds:' + gameInfo['LastRound'].toString()),
            Text('Winning Score:' + gameInfo['WinningScore'].toString()),
            const Divider(thickness: 4.0),
            SizedBox(
                height: 500,
                child:GameMoreInfoPlayers(gameInfo['id'], gameInfo['Winner']))
          ],
        ));
  }
}
