import 'package:flutter/material.dart';


//import 'package:six/main.dart';
class SideBar extends StatefulWidget {
  //const SideBar({Key? key}) : super(key: key);
  Map<String, int> currentscores;

  SideBar(this.currentscores);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      backgroundColor: Theme.of(context).backgroundColor,
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            width: double.infinity,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              'Sidebar',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
          ),
          ListTile(
              leading: Icon(Icons.score),
              title: Text("Current Scores"),
              onTap: () => Navigator.pushNamed(context, 'Scores',
                  arguments: widget.currentscores)),
          ListTile(
            leading: Icon(Icons.rule),
            title: Text("Rules"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Tips"),
            onTap: () => Navigator.pushNamed(context, 'Tips'),
          ),
          ListTile(
              leading: Icon(Icons.clear),
              title: Text("Quit Game"),
              onTap: () => Navigator.pushNamed(context, 'Quit')),
          ListTile(
            leading: Icon(Icons.info_sharp),
            title: Text("About"),
            onTap: null,
          )
          // Text("Rules"),
          // Text("Quit Game"),
          // Text("about")
        ],
      ),
    );
  }
}
