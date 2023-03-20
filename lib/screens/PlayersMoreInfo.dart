import 'package:flutter/material.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(player, style: TextStyle(fontSize: 26)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Highest Score: 255'),
                    Text('Most twelves in a game: 6'),
                    Text('Total Score: 525'),
                    Text('Total Twelves: 12'),
                  ],
                ),

              ],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Wins'),
                Text('5'),
              ],
            ),
            SizedBox(height: 32),
            Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jan 1'),
                Text('156'),
              ],
            )),
            Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jan 2'),
                Text('157'),
              ],
            )),
            Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jan 3'),
                Text('158'),
              ],
            )),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Loses'),
                Text('3'),
              ],
            ),
            SizedBox(height: 32),
            Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date: Jan 1'),
                    Text('Score: 156'),
                  ],
                )),
            Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date: Jan 2'),
                    Text('Score: 157'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
