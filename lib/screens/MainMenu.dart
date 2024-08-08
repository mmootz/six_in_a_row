import 'package:flutter/material.dart';
import 'GameBoard.dart';
import 'package:six/widgets/getPlayers.dart';
import 'package:six/data/games.dart';
import 'package:six/data/playerData.dart';
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
  late Future<List<dynamic>> _playersFuture;

  initPastGames() async {
    final List initPastGames = await Game.getGames();
    if (initPastGames.isEmpty) {
      debugPrint('print');
    }
    setState(() {
      pastGames = initPastGames;
    });
  }

  Future<List> _getPlayers() async {
    final List playersMap = await PlayerData.getRawData("SELECT PlayerName FROM players");
    for (var element in playersMap) {
      loadedPlayers.add(element['PlayerName']);
    }
    return loadedPlayers;
  }

  @override
  void initState() {
    super.initState();
    PlayerData.initDatabase();
    _playersFuture = _getPlayers();

  }

  void _showAddPlayer(context) {
    Navigator.pushNamed(context, 'AddPlayer');
  }

  void _showGameBoard(context) {
    if (selectedPlayers.length <= 1) {
      var snackBar = SnackBar(
        content: const Text('Not enough players!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
            label: 'Okay',
            textColor: Theme.of(context).canvasColor,
            onPressed: () => debugPrint('test')),
      );
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
        title: const Text('Six'),
        elevation: 6,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showAddPlayer(context),
            icon: const Icon(Icons.plus_one),
            tooltip: 'Clear score',
            splashColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      drawer: const MainMenuSideBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder<List<dynamic>>(
                future: _playersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No players added yet.'),
                    );
                  } else {
                    return GetPlayers(
                        selectedPlayers: selectedPlayers,
                        loadedPlayers: snapshot.data!.toList());
                  }
                },
              ),

              BottomButton(
                  text: 'Start Game', call: () => _showGameBoard(context)),

            ],
          ),
        ),
      ),
    );
  }
}
