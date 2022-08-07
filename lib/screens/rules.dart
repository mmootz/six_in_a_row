import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
        centerTitle: true,
      ),
      body: RichText(
        text: TextSpan(
            text: 'Staring Game',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
