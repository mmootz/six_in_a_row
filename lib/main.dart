import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/MainMenu.dart';
import 'screens/GameBoard.dart';
import 'screens/scores.dart';
import 'screens/WinScreen.dart';
import 'screens/tips.dart';
import 'screens/ExitGame.dart';
import 'screens/Players.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Six in a row',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  //List players = ["test", "test2"];
  //String player = "matt";
  //final Map<String, int> WinPlayers = {"Matt": 10, "Dad": 13};
  Map<String, int> ScoresMap = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Six in a row',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.lightBlueAccent),
        canvasColor: Colors.white,
      ),
      home: const MainMenu(),
      initialRoute: 'MainMenu' ,
      routes: {
        'MainMenu': (ctx) => MainMenu(),
        'GameBoard': (ctx) => GameBoard(),
        'Scores': (ctx) => Scores(),
        'WinScreen': (ctx) => WinScreen(),
        'Players' : (ctx) => playersPage(),
        'Tips': (ctx) => TipsPage(),
        'Quit': (ctx) => QuitGame()
      }, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
