import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:six/screens/AddPlayer.dart';
import 'package:six/screens/MainMenu.dart';




void main() {
  testWidgets('add player', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: AddplayersPage() ,
      routes: {
        'MainMenu': (ctx) => MainMenu(),
        'AddPlayer': (ctx) => AddplayersPage(),
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
  testWidgets('add player fail no entry', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: AddplayersPage() ,
      routes: {
        'MainMenu': (ctx) => MainMenu(),
        'AddPlayer': (ctx) => AddplayersPage(),
      }, // This trailing comma makes auto-form
    ));
    //Finder addPlayerButton = find.byIcon(Icons.plus_one);

    Finder playerbox = find.byKey(const ValueKey('PlayerNameBox'));
    Finder submitButton = find.byKey(const ValueKey('SubmitButton'));
    await tester.enterText(playerbox, '');
    await tester.tap(submitButton);
    Finder errorMessage = find.byKey(const ValueKey('SnackBarError'));
    expect(errorMessage, findsOneWidget);
  });
  testWidgets('add player fail too long', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: AddplayersPage() ,
      routes: {
        'MainMenu': (ctx) => MainMenu(),
        'AddPlayer': (ctx) => AddplayersPage(),
      }, // This trailing comma makes auto-form
    ));
    //Finder addPlayerButton = find.byIcon(Icons.plus_one);

    Finder playerbox = find.byKey(const ValueKey('PlayerNameBox'));
    Finder submitButton = find.byKey(const ValueKey('SubmitButton'));
    await tester.enterText(playerbox, 'test1');
    await tester.tap(submitButton);
    Finder errorMessage = find.text('Can not be empty or longer than 30 characters');
    expect(errorMessage, findsNothing);
  });
}


