import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:six/screens/Players.dart';
import '../data/playerData.dart';
import '../models/player.dart';
import 'package:six/widgets/playerCard.dart';

class getPlayers extends StatefulWidget {
  final List selectedPlayers;

  //final Function Selection;

  getPlayers({required this.selectedPlayers});

  @override
  State<getPlayers> createState() => _getPlayersState();
}

//HashSet<Player> players = HashSet();

class _getPlayersState extends State<getPlayers> {
  //const getPlayers({Key? key}) : super(key: key);
  //late final List<Map<String, dynamic>> playerList;

  //List selectedPlayers = [];

  // void multiSelection(String player) {
  //   if (selectedPlayers.contains(player)) {
  //     debugPrint('removed player');
  //     selectedPlayers.remove(player);
  //   } else {
  //     selectedPlayers.add(player);
  //     debugPrint('added player');
  //   }
  //    setState(() {
  //    });
  // }

  void multiSelection(String player) {
    if (widget.selectedPlayers.contains(player)) {
      debugPrint('removed player');
      widget.selectedPlayers.remove(player);
    } else {
      widget.selectedPlayers.add(player);
      debugPrint('added player');
    }
    setState(() {});
  }

  Future<List<Widget>> getPlayers() async {
    List<Widget> _loaded_players = [];
    final listplayers = await DBHelper.getData('players');
    listplayers.forEach((element) {
      _loaded_players.add(InkWell(
        onTap: () {
          multiSelection(element['playername']);
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: Colors.white,
          elevation: 4,
          margin: EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  element['playername'],
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 32),
                ),
                widget.selectedPlayers.contains(element['playername'])
                    ? Icon(Icons.circle)
                    : Icon(Icons.circle_outlined)
                //Text("Wins:" + element['wins'].toString()),
                //Text(element['wins']),
                // Text(element['losses']),
              ],
            ),
          ),
        ),
      ));
    });

    return _loaded_players;
  }

// https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
// likely need to figure this out.

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getPlayers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final players = snapshot.data as List<Widget>;
                return Column(
                  children: [
                    Text(widget.selectedPlayers.length.toString(),
                        style: TextStyle(fontSize: 25)),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: players),
                  ],
                );
              } else {
                return const Text('Add players to begin!');
              }
            }));
  }
}
