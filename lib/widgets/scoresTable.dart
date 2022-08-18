import 'package:flutter/material.dart';

class scoresTable extends StatelessWidget {
  //const scoresTable({Key? key}) : super(key: key);

  final Map<String, int> scores;
  final List<int> colorCodes = <int>[600, 500, 100];

  scoresTable(this.scores);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: scores.length,
          itemBuilder: (BuildContext context, int index) {
            String playername = scores.keys.elementAt(index);
            String playerscore = scores[playername].toString();
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              //color: Colors.blue[colorCodes[index]],
              child: Center(
                child: Column(
                  children: [
                    Text(
                      playername + ':' + playerscore,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const Divider(thickness: 2.0,)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
