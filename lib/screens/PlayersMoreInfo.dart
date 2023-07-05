import 'package:flutter/material.dart';
import 'package:six/widgets/playerWins.dart';
import 'package:six/widgets/PlayerStats.dart';
import 'package:six/data/player.dart';

class PlayersPageMoreInfo extends StatelessWidget {
  //const PlayersPageMoreInfo({Key? key}) : super(key: key);
  static const routeName = 'PlayersPageMoreInfo';

  void deletePlayer(context, String playername) {
    List stupidworkaround = [];
    stupidworkaround.add(playername);
    //player.deletePlayer(stupidworkaround);
    var snackBar = SnackBar(
      content: Text('Remove player?'),
      backgroundColor: Colors.red,
      action: SnackBarAction(
          label: 'Yes',
          textColor: Theme.of(context).canvasColor,
          onPressed: () => {
                player.deletePlayer(stupidworkaround),
                Navigator.popAndPushNamed(context, 'MainMenu')
              }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //
  }

  @override
  Widget build(BuildContext context) {
    final player = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              color: Colors.red,
              onPressed: () => deletePlayer(context, player),
              icon: const Icon(Icons.delete_forever),
              tooltip: 'Clear score',
              splashColor: Theme.of(context).primaryColorDark,
            ),
          ],
          title: const Text('More Info'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor),
      body: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(player, style: const TextStyle(fontSize: 26)),
                playerStats(player)
              ],
            ),
            const SizedBox(height: 32),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wins',
                      style: TextStyle(fontSize: 26),
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date'),
                    Text('Score'),
                  ],
                ),
                const Divider(
                  thickness: 2.0,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: playerWins(player)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
