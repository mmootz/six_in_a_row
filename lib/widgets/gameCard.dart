import 'package:flutter/material.dart';
import 'package:six/data/games.dart';

class gameCard extends StatefulWidget {
  //const gameCard(elementAt, {Key? key}) : super(key: key);

  final gameId;

  gameCard(this.gameId);

  @override
  State<gameCard> createState() => _gameCardState();
}

class _gameCardState extends State<gameCard> {
  Map<String, dynamic> loadedinfo = {};

  initGameInfo(gameId) async {
    var GameId = int.parse(gameId);
    final List<Map<String, dynamic>> intLoadedGameinfo =
        await Game.getGameInfo(GameId);
    // if (initLoadedplayers.isEmpty) {
    //   debugPrint('print');
    debugPrint("loaded info:" + intLoadedGameinfo[0].toString());
    // }
    setState(() {
      loadedinfo = intLoadedGameinfo[0];
    });
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initGameInfo(widget.gameId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'PastGamesMoreInfo',
          arguments: loadedinfo),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(loadedinfo['Date'].toString()),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loadedinfo['Winnner'].toString(),
                          style: TextStyle(fontSize: 26),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text("Score: " + loadedinfo['WinningScore'].toString(),
                    style: TextStyle(fontSize: 26)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
