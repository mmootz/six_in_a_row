import 'package:flutter/material.dart';
import 'package:six/data/games.dart';

class PlayerWins extends StatefulWidget {
  final String PlayerName;

  const PlayerWins(this.PlayerName, {Key? key}) : super(key: key);

  @override
  State<PlayerWins> createState() => _PlayerWinsState();
}

class _PlayerWinsState extends State<PlayerWins> {
  //const playerWins({Key? key}) : super(key: key);
  List loadedWins = [];

  initLoadedWins() async {
    final List initLoadedWins = await Game.getWins(widget.PlayerName);
    if (initLoadedWins.isEmpty) {
      debugPrint('Wins Empty');
    }
    setState(() {
      loadedWins = initLoadedWins;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLoadedWins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: loadedWins.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                leading: Text(loadedWins[index]['Date'].toString()),
                trailing: Text(loadedWins[index]['WinningScore'].toString()),
              ),
              const Divider(
                thickness: 2.0,
              )
            ],
          );
        });
  }
}
