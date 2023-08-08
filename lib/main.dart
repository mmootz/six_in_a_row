import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:six/screens/PastGames.dart';
import 'package:six/screens/PastGamesMoreInfo.dart';
import 'package:six/screens/PlayersMoreInfo.dart';
import 'package:six/screens/players.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/MainMenu.dart';
import 'screens/GameBoard.dart';
import 'screens/scores.dart';
import 'screens/WinScreen.dart';
import 'screens/About.dart';
import 'screens/AddPlayer.dart';
import 'screens/EditScore.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 20, 79, 163));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 5, 99, 125));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  DatabaseFactory? databaseFactoryFfi;
  databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class ChangeNotifierProvider {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Six in a row',
      home: const Main(title: 'Six in a row'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Map<String, int> ScoresMap = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Six in a row',
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: kDarkColorScheme,primaryColor: Colors.blue),
      theme: ThemeData(
      ).copyWith(useMaterial3: true, colorScheme: kColorScheme, primaryColor: Colors.lightBlue ),
      home: const MainMenu(),
      initialRoute: 'MainMenu',
      routes: {
        'MainMenu': (ctx) => MainMenu(),
        'GameBoard': (ctx) => GameBoard(),
        'Scores': (ctx) => Scores(),
        'WinScreen': (ctx) => WinScreen(),
        'AddPlayer': (ctx) => AddplayersPage(),
        'PlayersPage': (ctx) => PlayersPage(),
        'PlayersPageMoreInfo': (ctx) => PlayersPageMoreInfo(),
        'PastGames': (ctx) => pastGames(),
        'PastGamesMoreInfo': (ctx) => PastGamesMoreInfo(),
        'Edit': (ctx) => editScore(),
        'About': (ctx) => About()
      }, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
