import 'package:flutter/material.dart';

class QuitGame extends StatelessWidget {
  const QuitGame({Key? key}) : super(key: key);
  static const routeName = 'ExitGame';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exit Game'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                  'Press the button below to quit the current game \n'
                  ' or press back to return to return to current game',
                  textAlign: TextAlign.center),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.pop(context),
                  Navigator.pushReplacementNamed(context, 'MainMenu')
                },
                child: const Text('Quit game'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
