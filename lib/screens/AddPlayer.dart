import 'package:flutter/material.dart';
import 'package:six/data/player.dart';


class AddplayersPage extends StatefulWidget {
  //const playersPage({Key? key}) : super(key: key);
  static const routeName = 'Players';

  @override
  State<AddplayersPage> createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddplayersPage> {
  final newPlayerName = TextEditingController();

  Future<void> submitData(context, String playerName) async {
    String result = await Player.addPlayer(playerName);

    switch (result) {
      case 'Created':
        Navigator.pushNamed(context, 'MainMenu');
        break;
      case 'empty' :
        _showErrorSnackBar(context, 'Name cannot be empty');
        break;
      case 'too_long':
        _showErrorSnackBar(context, 'Name cannot be longer than 30 characters');
        break;
      case 'exists' :
        _showErrorSnackBar(context, 'Name already exists');
        break;
      default:
        _showErrorSnackBar(context, 'An unknown error occurred');
        break;
    }
  }

  void _showErrorSnackBar(BuildContext context, String message){
    var snackBar = SnackBar(
      key: const ValueKey('SnackBarError'),
      content: Text(message),
      backgroundColor: Theme.of(context).primaryColor,
      action: SnackBarAction(
        label: 'Okay',
        textColor: Theme.of(context).canvasColor,
        onPressed: () => debugPrint('SnackBar action pressed'),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Add Player'),
        centerTitle: true,
        elevation: 6,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
              decoration: const InputDecoration(labelText: "Playername"),
              controller: newPlayerName,
              onSubmitted: (_) => submitData(context,newPlayerName.text),
              key: const ValueKey('PlayerNameBox')),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => submitData(context,newPlayerName.text),
                child: const Text('Submit'),
                key: const ValueKey('SubmitButton'),
              ),
              const SizedBox(width: 75),
              TextButton(onPressed: () => Navigator.pushNamed(context, 'MainMenu'),
                child: const Text('Cancel'),),
            ],
          )
        ],
      ),
    );
  }
}
