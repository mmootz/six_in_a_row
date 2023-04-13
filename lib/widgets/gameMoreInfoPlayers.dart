import 'package:flutter/material.dart';
import 'package:six/data/games.dart';

//

class gameMoreInfoPlayers extends StatefulWidget {
//  const gameMoreInfoPlayers({Key? key}) : super(key: key);
  final gameId;
  final winner;

  gameMoreInfoPlayers(this.gameId, this.winner);

  @override
  State<gameMoreInfoPlayers> createState() => _gameMoreInfoPlayersState();
}

class _gameMoreInfoPlayersState extends State<gameMoreInfoPlayers> {
  List loadedPlayers = [];

  initloadedPlayers() async {
    final List initLoadedPlayers = await Game.getPlayers(widget.gameId);
    if (initLoadedPlayers.isEmpty) {
      debugPrint('print');
    }

    setState(() {
      loadedPlayers = initLoadedPlayers;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initloadedPlayers();
    });
  }

  bool winnerCheck(String winner, String player) {
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
        var player4 = item['ForthPlayer'];
        var player1Score = item['FirstPlayerScore'];
        var player2Score = item['SecondPlayerScore'];
        var player3Score = item['ThirdPlayerScore'];
        var player4Score = item['FourthPlayerScore'];
        return Column(
          children: [
            if (player1 != 'None')
              ListTile(
                leading: winnerCheck(widget.winner, player1)
                    ? Icon(Icons.bookmark)
                    : Text(" "),
                title: Text(player1),
                trailing: Text('Score: $player1Score'),
                iconColor: Theme.of(context).colorScheme.primary,
              ),
            if (player2 != 'None')
              ListTile(
                leading: winnerCheck(widget.winner, player2)
                    ? Icon(Icons.bookmark)
                    : Text(" "),
                title: Text(player2),
                trailing: Text('Score: $player2Score'),
                iconColor: Theme.of(context).colorScheme.primary,
              ),
            if (player3 != 'None')
              ListTile(
                title: Text(player3),
                subtitle: Text('Score: $player3Score'),
                iconColor: Theme.of(context).colorScheme.primary,
              ),
            if (player4 != 'None')
              ListTile(
                title: Text(player4),
                subtitle: Text('Score: $player4Score'),
                iconColor: Theme.of(context).colorScheme.primary,
              ),
          ],
        );
      },
    );
  }
}
