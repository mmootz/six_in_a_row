import 'package:flutter/material.dart';

class MainMenuSideBar extends StatelessWidget {
  const MainMenuSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: double.infinity,
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: const Text(
            'Options',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
        ),
        ListTile(
            leading: const Icon(Icons.plus_one),
            title: const Text("Add Player"),
            //iconColor: Theme.of(context).colorScheme.secondary,
            onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, 'AddPlayer')
                }),
        ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Players"),
            onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, 'PlayersPage')
                }),
        ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Past Games"),
            onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, 'PastGames')
                }),
        ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, 'About')
                }),
      ]),
    );
  }
}
