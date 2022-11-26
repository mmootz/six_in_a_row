import 'package:flutter/material.dart';
import 'package:six/widgets/getPlayers.dart';
import 'package:six/data/player.dart';

class playersPage extends StatefulWidget {
  //const playersPage({Key? key}) : super(key: key);
  static const routeName = 'Players';

  @override
  State<playersPage> createState() => _playersPageState();
}

class _playersPageState extends State<playersPage> {
  final newPlayerName = TextEditingController();
  List selectedPlayers = [];
  List loadedPlayers = [];
  List deletedplayers = [];

  Future<List> loadplayers() async {
    loadedPlayers = await player.getPlayers();
    return loadedPlayers;
  }

  void deletePlayer(String playername) {
    List stupidworkaround = [];
    stupidworkaround.add(playername);
    player.deletePlayer(stupidworkaround);
  }

  @override
  didChangeDependencies() async {
    loadedPlayers = await loadplayers();
  }

  submitData() async {
    if (newPlayerName.text.isNotEmpty) {
      player.addPlayer(newPlayerName.text);
      Navigator.pop(context, newPlayerName.text);
    } else {
      // popup here or toast I guess
      debugPrint('empty');
    }
    //Navigator.pushNamed(context, 'MainMenu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              selectedPlayers.forEach((element) {
                deletePlayer(element);
              }),
            },
            icon: const Icon(Icons.delete),
            tooltip: 'Clear score',
            splashColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Playername"),
            controller: newPlayerName,
            onSubmitted: (_) => submitData(),
          ),
          TextButton(
            onPressed: submitData,
            child: Text('Submit1'),
          ),
          //getPlayers()
          getPlayers(
              selectedPlayers: selectedPlayers, loadedPlayers: loadedPlayers)
        ],
      ),
    );
  }
}
