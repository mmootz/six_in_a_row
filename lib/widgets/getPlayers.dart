import 'package:flutter/material.dart';
import 'package:six/screens/Players.dart';
import '../data/playerData.dart';
import '../models/player.dart';
import 'package:six/widgets/playerCard.dart';

class getPlayers extends StatefulWidget {
  @override
  State<getPlayers> createState() => _getPlayersState();
}

class _getPlayersState extends State<getPlayers> {
  //const getPlayers({Key? key}) : super(key: key);
  //late final List<Map<String, dynamic>> playerList;
  Future<List<Widget>> getPlayers() async {
    List<Widget> _loaded_players = [];
    final listplayers = await DBHelper.getData('players');
    listplayers.forEach((element) {
      _loaded_players.add( InkWell(
        onTap: () => debugPrint(element['playername']),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          elevation: 6,
          margin: EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            child: Column(
              children: [

                Text(
                  element['playername'],
                  style: TextStyle(fontSize: 26),
                ),
                Text("Wins:" + element['wins'].toString()),
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
                return Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: players));
              } else {
                return Container();
              }
            }));
  }
}
