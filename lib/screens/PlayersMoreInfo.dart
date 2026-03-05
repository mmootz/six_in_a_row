import 'package:flutter/material.dart';
import 'package:six/widgets/playerWins.dart';
import 'package:six/widgets/PlayerStats.dart';
import 'package:six/data/player.dart';

class PlayersPageMoreInfo extends StatelessWidget {

  static const routeName = 'PlayersPageMoreInfo';
  const PlayersPageMoreInfo({Key? key}) : super(key: key);

  void deletePlayer(context, String playerName) {
    List stupidWorkAround = [];
    stupidWorkAround.add(playerName);

    var snackBar = SnackBar(
      content: const Text('Remove player?'),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      action: SnackBarAction(
          label: 'Yes',
          textColor: Theme.of(context).canvasColor,
          onPressed: () => {
                Player.deletePlayer(stupidWorkAround),
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
          // choose a color that contrasts with the app bar background so the
          // delete button doesn't disappear when the user picks a red theme.
          Builder(builder: (ctx) {
            final bg = Theme.of(ctx).primaryColor;
            // if the background colour is red (or basically identical) we don't
            // want a red icon since it becomes invisible. fall back to black in
            // that case, otherwise use red for emphasis.
            Color iconColor = Colors.red;
            if (bg == Colors.red || bg.value == iconColor.value) {
              iconColor = Colors.black;
            }

            return IconButton(
              color: iconColor,
              onPressed: () => deletePlayer(ctx, player),
              icon: const Icon(Icons.delete_forever),
              tooltip: 'Clear score',
              splashColor: Theme.of(ctx).primaryColorDark,
            );
          }),
        ],
        title: const Text('More Info'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 6,
      ),
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
                    child: PlayerWins(player)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
