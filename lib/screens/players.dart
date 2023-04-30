import 'package:flutter/material.dart';
import 'package:six/widgets/playerCard.dart';
import 'package:six/data/player.dart';

class PlayersPage extends StatefulWidget {
  // const PlayersPage({Key? key}) : super(key: key);
  static const routeName = 'PlayersPage';

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List loadedPlayers = [];
  Map PlayerInfo = {};

  initloadedPlayers() async {
    final List initLoadedplayers = await player.getPlayers();
    if (initLoadedplayers.isEmpty) {
      debugPrint('print');
    }
    setState(() {
      loadedPlayers = initLoadedplayers;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initloadedPlayers();
    });
  }

  // Playerinfo(playername) async {
  //   List<Map<String,dynamic >> info = [];
  //
  //   info = await player.getPlayerInfo(playername);
  //   debugPrint(info.toString());
  //
  //   //return info;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Players'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor),
        body: ListView.builder(
          itemCount: loadedPlayers.length,
          itemBuilder: (BuildContext context, int index) {
            return PlayerCard(loadedPlayers.elementAt(index));
          },
        ));
  }
}
