

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:six/screens/PlayersMoreInfo.dart';
import 'package:six/screens/players.dart';
import 'screens/MainMenu.dart';
import 'screens/GameBoard.dart';
import 'screens/scores.dart';
import 'screens/WinScreen.dart';
import 'screens/ExitGame.dart';
import 'screens/AddPlayer.dart';
import 'screens/EditScore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class ChangeNotifierProvider {
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Six in a row',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Six in a row'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Map<String, int> ScoresMap = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Six in a row',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue)
            .copyWith(secondary: Colors.blueAccent),
        canvasColor: Colors.white,
      ),
      home: const MainMenu(),
      initialRoute: 'MainMenu',
      routes: {
        'MainMenu': (ctx) => MainMenu(),
        'GameBoard': (ctx) => GameBoard(),
        'Scores': (ctx) => Scores(),
        'WinScreen': (ctx) => WinScreen(),
        'AddPlayer': (ctx) => AddplayersPage(),
        'PlayersPage' : (ctx) => PlayersPage(),
        'PlayersPageMoreInfo' : (ctx) => PlayersPageMoreInfo(),
        'Edit': (ctx) => editScore(),
        'Quit': (ctx) => QuitGame()
      }, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
