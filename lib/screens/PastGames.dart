import 'package:six/data/games.dart';
import 'package:flutter/material.dart';
import 'package:six/widgets/gameCard.dart';

class pastGames extends StatefulWidget {
  const pastGames({Key? key}) : super(key: key);

  @override
  State<pastGames> createState() => _PastGamesState();
}

class _PastGamesState extends State<pastGames> {
//  const pastGames({Key? key}) : super(key: key);
  List loadedGames = [];

  initLoadedGames() async {
    final List initLoadedGames = await Game.getGames();
    if (initLoadedGames.isEmpty) {
      debugPrint('print');
    }

    setState(() {
      loadedGames = initLoadedGames;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLoadedGames();
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
            return GameCard(loadedGames.elementAt(index));
          },
        ));
  }
}
