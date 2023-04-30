import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:six/main.dart';
import 'package:six/screens/AddPlayer.dart';
import 'package:six/screens/MainMenu.dart';
import 'package:six/screens/GameBoard.dart';
import 'package:mockito/mockito.dart';


void main() {
  testWidgets('add player', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: AddplayersPage() ,
      routes: {
        'MainMenu': (ctx) => MainMenu(),
        'GameBoard': (ctx) => GameBoard(),
      }, // This trailing comma makes auto-form
    ));
    //Finder addPlayerButton = find.byIcon(Icons.plus_one);

    Finder playerbox = find.byKey(const ValueKey('PlayerNameBox'));
    Finder submitButton = find.byKey(const ValueKey('SubmitButton'));
    await tester.enterText(playerbox, 'test1');
    await tester.tap(submitButton);
    Finder errorMessage = find.text('Can not be empty or longer than 30 characters');
    Finder addedPlayer = find.text('test1');
    expect(addedPlayer, findsOneWidget);
  });
}