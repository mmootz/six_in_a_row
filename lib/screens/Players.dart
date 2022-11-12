import 'package:flutter/material.dart';
import 'package:six/data/playerData.dart';
import 'package:six/models/player.dart';
import 'package:six/widgets/getPlayers.dart';

class playersPage extends StatefulWidget {
  //const playersPage({Key? key}) : super(key: key);
  static const routeName = 'Players';

  @override
  State<playersPage> createState() => _playersPageState();
}

class _playersPageState extends State<playersPage> {
  final newPlayerName = TextEditingController();

  submitData() async {
    int newID = 0;
    //getId = await DBHelper.runCommand('SELECT MAX(id) FROM players);
    final getid = await DBHelper.getRawData('SELECT MAX(id) FROM players');
    //debugPrint(getid[0]['MAX(id)'].toString());
    if (getid[0]['MAX(id)'] != null) {
      newID = getid[0]['MAX(id)'];
      newID ++;
    }
    debugPrint(newID.toString());
    DBHelper.insert('players',
        {'id': newID, 'playername': newPlayerName.text, 'wins': 0, 'losses': 0});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Playname"),
            controller: newPlayerName,
            onSubmitted: (_) => submitData(),
            // onChanged: (value) {
            //   titleInput = value;
            // },
          ),
          TextButton(
            onPressed: submitData,
            child: Text('Submit'),
          ),
          //getPlayers()
        ],
      ),
    );
  }
}
