import 'package:flutter/material.dart';
import 'package:six/data/player.dart';
import 'package:six/data/playerData.dart';

class AddplayersPage extends StatefulWidget {
  //const playersPage({Key? key}) : super(key: key);
  static const routeName = 'Players';

  @override
  State<AddplayersPage> createState() => _AddplayersPageState();
}

class _AddplayersPageState extends State<AddplayersPage> {
  final newPlayerName = TextEditingController();

  Future<void> submitData(context, String playername) async {
    if (playername.isNotEmpty && playername.length < 30) {
     player.addPlayer(playername);

     // Navigator.pushReplacementNamed(context, 'MainMenu');
      //Navigator.popAndPushNamed(context, 'MainMenu');
        Navigator.pushNamed(context, 'MainMenu');
    } else {
      // popup here or toast I guess
      var SnackBarVar = SnackBar(
        key: const ValueKey('SnackBarError'),
        content: Text('Can not be empty or longer than 30 characters'),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        action: SnackBarAction(
            label: 'Okay',
            textColor: Theme
                .of(context)
                .canvasColor,
            onPressed: () => debugPrint('test')),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBarVar);
    }
    //Navigator.pushNamed(context, 'MainMenu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Add Player'),
        centerTitle: true,
        elevation: 6,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
              decoration: InputDecoration(labelText: "Playername"),
              controller: newPlayerName,
              onSubmitted: (_) => submitData(context,newPlayerName.text),
              key: const ValueKey('PlayerNameBox')),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => submitData(context,newPlayerName.text),
                child: Text('Submit'),
                key: const ValueKey('SubmitButton'),
              ),
              SizedBox(width: 75),
              TextButton(onPressed: () => Navigator.pushNamed(context, 'MainMenu'),
                child: Text('Cancel'),),
            ],
          )
        ],
      ),
    );
  }
}
