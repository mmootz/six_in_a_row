import 'package:flutter/material.dart';
import 'package:six/data/games.dart';

//

class GameMoreInfoPlayers extends StatefulWidget {
//  const gameMoreInfoPlayers({Key? key}) : super(key: key);
  final gameId;
  final winner;

  const GameMoreInfoPlayers(this.gameId, this.winner, {Key? key})
      : super(key: key);

  @override
  State<GameMoreInfoPlayers> createState() => _GameMoreInfoPlayersState();
}

class _GameMoreInfoPlayersState extends State<GameMoreInfoPlayers> {
  List loadedPlayers = [];

  initLoadedPlayers() async {
    final List initLoadedPlayers = await Game.getPlayers(widget.gameId);
    if (initLoadedPlayers.isEmpty) {
      debugPrint('print');
    }

    setState(() {
      loadedPlayers = initLoadedPlayers;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLoadedPlayers();
    });
  }

  bool winnerCheck(String winner, String player) {
    debugPrint("winner: " + winner + "player:" + player);

    if (winner == player) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: loadedPlayers.length,
      itemBuilder: (context, index) {
        var item = loadedPlayers[index];
        var player1 = item['FirstPlayer'];
        var player2 = item['SecondPlayer'];
        var player3 = item['ThirdPlayer'];
        var player4 = item['FourthPlayer'];
        return Column(
          children: [
            if (player1 != 'None')
              ListTile(
                leading: winnerCheck(widget.winner, player1)
                    ? const Icon(Icons.bookmark)
                    : const Text(" "),
                title: Text(player1),
                trailing: Text(loadedPlayers[0]['FirstPlayerScore'].toString()),
                iconColor: Theme.of(context).primaryColor,
              ),
            if (player2 != 'None')
              ListTile(
                leading: winnerCheck(widget.winner, player2)
                    ? const Icon(Icons.bookmark)
                    : const Text(" "),
                title: Text(player2),
                trailing: Text(loadedPlayers[0]['SecondPlayerScore'].toString()),
                iconColor: Theme.of(context).primaryColor,
              ),
            if (player3 != 'None')
              ListTile(
                leading: winnerCheck(widget.winner, player3)
                    ? const Icon(Icons.bookmark)
                    : const Text(" "),
                title: Text(player3),
                trailing: Text(loadedPlayers[0]['ThirdPlayerScore'].toString()),
                iconColor: Theme.of(context).primaryColor,
              ),
            if (player4 != 'None')
              ListTile(
                leading: winnerCheck(widget.winner, player4)
                    ? const Icon(Icons.bookmark)
                    : const Text(" "),
                title: Text(player4),
                trailing: Text(loadedPlayers[0]['FourthPlayerScore'].toString()),
                iconColor: Theme.of(context).primaryColor,
              ),
          ],
        );
      },
    );
  }
}
