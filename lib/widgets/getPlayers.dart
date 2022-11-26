
import 'package:flutter/material.dart';


class getPlayers extends StatefulWidget {
  final List selectedPlayers;
  final List loadedPlayers;

  //final Function Selection;

  getPlayers({required this.selectedPlayers, required this.loadedPlayers});

  @override
  State<getPlayers> createState() => _getPlayersState();
}

//HashSet<Player> players = HashSet();

class _getPlayersState extends State<getPlayers> {
  //const getPlayers({Key? key}) : super(key: key);
  //late final List<Map<String, dynamic>> playerList;
  int selectedPlayersNum = 0;

  void multiSelection(String player) {
    if (widget.selectedPlayers.contains(player)) {
      debugPrint('removed player');
      widget.selectedPlayers.remove(player);
    } else {
      widget.selectedPlayers.add(player);
      debugPrint('added player');
    }
    setState(() {});
  }

// https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
// likely need to figure this out.

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: ListView.separated(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: widget.loadedPlayers.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Theme.of(context).primaryColor,
                onTap: () {
                  multiSelection(widget.loadedPlayers[index]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment,
                  children: [
                    Text(
                      widget.loadedPlayers[index],
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 32),
                    ),
                    widget.selectedPlayers.contains(widget.loadedPlayers[index])
                        ? Icon(Icons.check_box, color: Theme.of(context).primaryColor,)
                        : Icon(Icons.check_box_outline_blank, color: Theme.of(context).primaryColor),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
      return Divider(thickness: 2.0);
      },
            ),
      ),
    );
  }}
