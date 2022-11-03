import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  //const PlayerCard({Key? key}) : super(key: key);

  final String PlayerName;
  final String Wins;
  final String Losses;

  //final Function selectedButton;
  //final Function playerManagment;

  PlayerCard(this.PlayerName, this.Wins, this.Losses);

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: null,
      //onTap: () => playerManagment(PlayerName),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.50,
          child: Column(
            children: [
              Text(
                PlayerName,
                style: TextStyle(fontSize: 26),
              ),
              // Text("Wins:$Wins"),
              // Text("Losses: $Losses")
            ],
          ),
        ),
      ),
    );
  }
}
