import 'package:flutter/material.dart';

//import 'package:six/main.dart';
class SideBar extends StatefulWidget {
  //const SideBar({Key? key}) : super(key: key);
  Map players;

  SideBar(this.players);

  @override
  State<SideBar> createState() => _SideBarState();
}

  quitGame(context) {
  Navigator.pop(context);
  Navigator.pushNamed(context, 'MainMenu');
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      backgroundColor: Theme
          .of(context).colorScheme.background,
      child: ListView(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.10,
            width: double.infinity,
            alignment: Alignment.center,
            color: Theme
                .of(context).colorScheme.secondary,
            child: const Text(
              'Options',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
          ),
          // ListTile(
          //     leading: Icon(Icons.score),
          //     title: Text("Current Scores"),
          //     onTap: () =>
          //     {
          //       Navigator.pop(context),
          //       Navigator.pushNamed(context, 'Scores',
          //           arguments: widget.players)
          //     }),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Scores"),
              onTap: () =>
              {
                Navigator.pop(context),
                Navigator.pushNamed(context, 'Edit',
                    arguments: widget.players)
              }),
          ListTile(
            leading: Icon(Icons.rule),
            title: Text("Rules"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Players"),
            onTap: () => Navigator.pushNamed(context, 'Players'),
          ),
          ListTile(
              leading: Icon(Icons.clear),
              title: Text("Quit Game"),
              onTap: () =>
              {
                Navigator.pop(context),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Quit'),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColorDark,
                    action: SnackBarAction(
                      label: 'Okay',
                      textColor: Theme
                          .of(context)
                          .canvasColor,
                      onPressed: () => Navigator.pushNamed(context, 'MainMenu'),
                    )))
              }),
          ListTile(
            leading: Icon(Icons.info_sharp),
            title: Text("About"),
            onTap: null,
          ),
          ListTile(
              leading: Icon(Icons.done_all),
              title: Text("End Game"),
              onTap: () =>
              {
                Navigator.pop(context),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('End Game'),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColorDark,
                    action: SnackBarAction(
                        label: 'Yes',
                        textColor: Theme
                            .of(context)
                            .canvasColor,
                        onPressed: () => debugPrint('End Game'))))
              })
        ],
      ),
    );
  }
}
