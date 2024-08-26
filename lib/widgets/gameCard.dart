import 'package:flutter/material.dart';
import 'package:six/data/games.dart';

class GameCard extends StatefulWidget {
  final gameId; // come back to this.

  const GameCard(this.gameId, {Key? key}) : super(key: key);

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  Map<String, dynamic> loadedInfo = {};

  initGameInfo(gameId) async {
    var gameIdParsed = int.parse(gameId);
    final List<Map<String, dynamic>> intLoadedGameInfo =
        await Game.getGameInfo(gameIdParsed);

    setState(() {
      loadedInfo = intLoadedGameInfo[0];
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initGameInfo(widget.gameId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'PastGamesMoreInfo',
          arguments: loadedInfo),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).canvasColor,
        elevation: 6,
        margin: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(loadedInfo['Date'].toString(),
                    style: const TextStyle(fontSize: 26)),
                Text(loadedInfo['Winner'].toString()),
                Text("Score: " + loadedInfo['WinningScore'].toString()),
              ],
            ),

            // Column(
            //   children: [
            //     Text("Score: " + loadedInfo['WinningScore'].toString(),
            //         style: const TextStyle(fontSize: 26)),
            //     SizedBox(height: 10,)
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
