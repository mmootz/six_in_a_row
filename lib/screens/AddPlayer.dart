import 'package:flutter/material.dart';
import 'package:six/data/player.dart';

class AddplayersPage extends StatefulWidget {
  //const playersPage({Key? key}) : super(key: key);
  static const routeName = 'Players';

  @override
  State<AddplayersPage> createState() => _AddplayersPageState();
}

class _AddplayersPageState extends State<AddplayersPage> {
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
        title: Text('Add Player'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Playername"),
            controller: newPlayerName,
            onSubmitted: (_) => submitData(),
            key: const ValueKey('PlayerNameBox')
          ),
          TextButton(
            onPressed: submitData,
            child: Text('Submit'),
            key: const ValueKey('SubmitButton'),
          ),
        ],
      ),
    );
  }
}