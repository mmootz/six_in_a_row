import 'package:flutter/material.dart';
import 'package:six/data/player.dart';
class PlayerCard extends StatefulWidget {
  //const PlayerCard({Key? key}) : super(key: key);

  final String playerName;
  
  const PlayerCard(this.playerName, {Key? key}) : super(key: key);

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {

  Map<String, dynamic> loadedInfo = {};

  initPlayerInfo(playerName) async {
    final List<Map<String, dynamic>> intLoadedPlayerInfo = await Player.getPlayerInfo(playerName);
    setState(() {
      loadedInfo = intLoadedPlayerInfo[0];
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPlayerInfo(widget.playerName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'PlayersPageMoreInfo',
          arguments: widget.playerName),
      splashColor: Theme.of(context).primaryColorDark,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).canvasColor,
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.playerName,
                        style: const TextStyle(fontSize: 26),
                        textAlign: TextAlign.center),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Highest Score: ' + loadedInfo['HighestScore'].toString()),
                    Text('Games Played: ' + loadedInfo['GamesPlayed'].toString() ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                const Text('Wins'),
                Text(loadedInfo['wins'].toString(), style: const TextStyle(fontSize: 26))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
