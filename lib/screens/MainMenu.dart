import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GameBoard.dart';
import 'package:six/widgets/getPlayers.dart';
import 'package:six/data/player.dart';
import 'package:six/data/games.dart';
import 'package:six/widgets/BottomButton.dart';
import 'package:six/widgets/MainMenuSidebar.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List selectedPlayers = [];
  List loadedPlayers = [];
  List pastGames = [];


  initpastGames() async {
    final List initpastGames = await Game.getGames();
    if (initpastGames.isEmpty) {
      debugPrint('print');
    }
    setState(() {
      pastGames = initpastGames;
    });
  }

  initloadedPlayers() async {
    final List initLoadedplayers = await player.getPlayers();
    if (initLoadedplayers.isEmpty) {
      debugPrint('print');
    }
    setState(() {
      loadedPlayers = initLoadedplayers;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initloadedPlayers();
      initpastGames();
    });
  }

  void _showaddPlayer(context) {
    //Navigator.pop(context);
    Navigator.pushNamed(context, 'AddPlayer');
  }

  void _showGameboard(context) {
    if (selectedPlayers.length <= 1) {
      var snackBar = SnackBar(
        content: Text('Not enough players!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action:
            SnackBarAction(label: 'Okay', textColor: Theme.of(context).canvasColor , onPressed: () => debugPrint('test')),
      );
      // debugPrint('Not enough players');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.pop(context);
      Navigator.pushNamed(context, GameBoard.routeName,
          arguments: selectedPlayers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Six in a row'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showaddPlayer(context),
            icon: const Icon(Icons.plus_one),
            tooltip: 'Clear score',
            splashColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
      drawer: MainMenuSideBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: initloadedPlayers, child: Text('Refresh')),
            //  Text('Select Players'),
              loadedPlayers.isNotEmpty
                  ? getPlayers(
                      loadedPlayers: loadedPlayers,
                      selectedPlayers: selectedPlayers)
                  : Text('Add players to start!\n or not I am not your boss'),
              BottomButton(text: 'Start Game', call: () => _showGameboard(context))
            ],
          ),
        ),
      ),

    );
  }
}
