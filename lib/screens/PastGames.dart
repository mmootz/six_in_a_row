import 'package:six/data/games.dart';
import 'package:flutter/material.dart';
import 'package:six/widgets/gameCard.dart';

class pastGames extends StatefulWidget {
  @override
  State<pastGames> createState() => _pastGamesState();
}

class _pastGamesState extends State<pastGames> {
//  const pastGames({Key? key}) : super(key: key);
  List loadedGames = [];

  initloadedGames() async {
    final List initLoadedGames = await Game.getGames();
    if (initLoadedGames.isEmpty) {
      debugPrint('print');
    }

    setState(() {
      loadedGames = initLoadedGames;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initloadedGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Past Games'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 6,
        ),
        body: ListView.builder(
          itemCount: loadedGames.length,
          itemBuilder: (BuildContext context, int index) {
            return gameCard(loadedGames.elementAt(index));
          },
        ));
  }
}
