import 'package:flutter/material.dart';
import 'package:six/widgets/playerCard.dart';
import 'package:six/data/player.dart';

class PlayersPage extends StatefulWidget {
  // const PlayersPage({Key? key}) : super(key: key);
  static const routeName = 'PlayersPage';

  const PlayersPage({Key? key}) : super(key: key);

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List loadedPlayers = [];
  Map playerInfo = {};

  initLoadedPlayers() async {
    final List initLoadedPlayers = await Player.getPlayers();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 6,
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
