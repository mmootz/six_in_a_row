import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:six/screens/AddPlayer.dart';
import 'package:flutter/widgets.dart';
void main () {
  testWidgets(
      'Add player test',
          (WidgetTester tester) async {

          tester.pumpWidget(AddplayersPage());

          Finder playernamebox = find.byKey(const ValueKey("PlayerNameBox"));
          await tester.enterText(playernamebox, 'Alice');
          Finder errorText = find.text('Must Enter name');
          expect(errorText, findsNothing);
      });
}