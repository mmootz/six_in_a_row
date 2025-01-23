import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:six/screens/PastGames.dart';
import 'package:six/screens/PastGamesMoreInfo.dart';
import 'package:six/screens/PlayersMoreInfo.dart';
import 'package:six/screens/players.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/MainMenu.dart';
import 'screens/GameBoard.dart';
import 'screens/scores.dart';
import 'screens/WinScreen.dart';
import 'screens/About.dart';
import 'screens/AddPlayer.dart';
import 'screens/EditScore.dart';
import 'screens/ColorPicker.dart';



var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 20, 79, 163));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class ChangeNotifierProvider {}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Six',
      home: Main(title: 'Six'),
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
  Color _primaryColor = Colors.blue;
  Map<String, int> ScoresMap = {};

  @override
  void initState() {
    super.initState();
    _loadSavedColor();
  }

  // Load saved color from shared preferences
  void _loadSavedColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedColorValue = prefs.getInt('primaryColor');
    if (savedColorValue != null) {
      setState(() {
        _primaryColor = Color(savedColorValue);
      });
    }
  }

  // Save selected color to shared preferences
  void _saveColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColor', color.value);
  }

  // Function to change the color dynamically
  void _changeColor(Color color) {
    setState(() {
      _primaryColor = color;
    });
    _saveColor(color);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Six',
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: kDarkColorScheme,primaryColor: _primaryColor),
      theme: ThemeData(
      ).copyWith(useMaterial3: true, colorScheme: kColorScheme, primaryColor: _primaryColor),
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
        'Edit': (ctx) => EditScore(),
        'About': (ctx) => About(),
        'ColorPicker': (ctx) => ColorPickerScreen(onColorSelected: _changeColor)

      }, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
