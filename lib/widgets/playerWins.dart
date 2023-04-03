import 'package:flutter/material.dart';
import 'package:six/data/games.dart';

class playerWins extends StatefulWidget {
  final String PlayerName;

  playerWins(this.PlayerName);

  @override
  State<playerWins> createState() => _playerWinsState();
}

class _playerWinsState extends State<playerWins> {
  //const playerWins({Key? key}) : super(key: key);
  List loadedWins = [];

  initloadedWins() async {
    final List initLoadedWins = await Game.getWins(widget.PlayerName);
    if (initLoadedWins.isEmpty) {
      debugPrint('print');
    }

    print(initLoadedWins.toString().length);
    setState(() {
      loadedWins = initLoadedWins;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initloadedWins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: loadedWins.map((item) {
      return Column(
        children: [
          ListTile(
            leading: Text(item['Date'].toString()),
            trailing: Text(item['WinningScore'].toString()),
          ),
          Divider(thickness: 2.0,)
        ],
      );
    }).toList());
  }
}
