import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GameBoard.dart';
import 'package:six/widgets/getPlayers.dart';
import 'package:six/data/player.dart';
import 'package:six/data/games.dart';
import 'package:six/data/playerData.dart';
import 'package:six/widgets/BottomButton.dart';
import 'package:six/widgets/MainMenuSidebar.dart';
import 'package:six/models/player.dart';

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

  Future<List> _getPlayers() async {
    final List playerList = [];
    final List playersMap = await playerData.getRawData("SELECT playername FROM players");
    for (var element in playersMap) {
      loadedPlayers.add(element['playername']);
    }
    return loadedPlayers;
  }

  @override
  void initState() {
    super.initState();
    playerData.initDatabase();
  }

  // @override
  // didChangeDependencies() async {
  //   initloadedPlayers();
  // }

  void _showaddPlayer(context) {
    //Navigator.pop(context);
    Navigator.pushNamed(context, 'AddPlayer');
  }

  void _showGameboard(context) {
    if (selectedPlayers.length <= 1) {
      var snackBar = SnackBar(
        content: Text('Not enough players!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
            label: 'Okay',
            textColor: Theme.of(context).canvasColor,
            onPressed: () => debugPrint('test')),
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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Six in a row'),
        elevation: 6,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showaddPlayer(context),
            icon: const Icon(Icons.plus_one),
            tooltip: 'Clear score',
            splashColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      drawer: MainMenuSideBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder<List<dynamic>>(
                future: _getPlayers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No players added yet.'),
                    );
                  } else {
                    return getPlayers(
                        selectedPlayers: selectedPlayers,
                        loadedPlayers: snapshot.data!.toList());
                  }
                },
              ),

              BottomButton(
                  text: 'Start Game', call: () => _showGameboard(context)),

            ],
          ),
        ),
      ),
    );
  }
}
