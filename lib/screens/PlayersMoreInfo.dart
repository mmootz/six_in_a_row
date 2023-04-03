import 'package:flutter/material.dart';
import 'package:six/widgets/playerWins.dart';
import 'package:six/widgets/PlayerStats.dart';

class PlayersPageMoreInfo extends StatelessWidget {
  //const PlayersPageMoreInfo({Key? key}) : super(key: key);
  static const routeName = 'PlayersPageMoreInfo';

  @override
  Widget build(BuildContext context) {
    final player = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('More Info'), centerTitle: true),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Wins',
                      style: TextStyle(fontSize: 26),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Date'),
                    const Text('Score'),
                  ],
                ),
                const Divider(
                  thickness: 2.0,
                ),
                playerWins(player),
              ],
            ),

            //       SizedBox(height: 32),
            //       ListView(children: [
            //       ListTile(leading: Text('Jan 1'), trailing: Text('156'),
            //     ]),
            //
            // ),
            //Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            //  children: [
            //    Text('Loses'),
            //    Text('3'),
            //  ],
            // ),

            // Card(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text('Date: Jan 1'),
            //         Text('Score: 156'),
            //       ],
            //     )),
            // Card(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text('Date: Jan 2'),
            //         Text('Score: 157'),
            //       ],
            //     )),
            ElevatedButton(onPressed: null, child: Text('Delete Player'))
          ],
        ),
      ),
    );
  }
}
