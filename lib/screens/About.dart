import 'package:flutter/material.dart';

// this might not be needed.
class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);
  static const routeName = 'ExitGame';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        elevation: 6,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                  'Made to learn more about Flutter and app development.\n',
                  textAlign: TextAlign.center),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Tips \n',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022 During play tap entered score to clear mistakes',
                    textAlign: TextAlign.left,
                  ),
                  Text('\u2022 Long press any score button to double the value',
                      textAlign: TextAlign.left),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
