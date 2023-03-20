import 'package:flutter/material.dart';
import 'package:six/data/player.dart';
class PlayerCard extends StatefulWidget {
  //const PlayerCard({Key? key}) : super(key: key);

  final String PlayerName;

  // final String Losses;

  //final Function selectedButton;
  //final Function playerManagment;



  PlayerCard(this.PlayerName);

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {

  Map<String, dynamic> loadedinfo = {};

  initPlayerInfo(playername) async {
    final List<Map<String, dynamic>> intLoadedPlayerinfo = await player.getPlayerInfo(playername);
    // if (initLoadedplayers.isEmpty) {
    //   debugPrint('print');
    // }
    setState(() {
      loadedinfo = intLoadedPlayerinfo[0];
    });
    debugPrint(loadedinfo.toString());
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPlayerInfo(widget.PlayerName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'PlayersPageMoreInfo',
          arguments: widget.PlayerName),
      //onTap: () => playerManagment(PlayerName),
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
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.PlayerName,
                          style: TextStyle(fontSize: 26),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Highest Score: ' + loadedinfo['Highestscore'].toString()),
                      Text('Games Played: ' + loadedinfo['Gamesplayed'].toString() ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text('Wins'),
                Text(loadedinfo['wins'].toString(), style: TextStyle(fontSize: 26))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
