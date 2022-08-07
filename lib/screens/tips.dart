import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({Key? key}) : super(key: key);
  static const routeName = 'Tips';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
              'Try to maximize the points you can get per tile \n Second Line '),
        ],
      ),
    );
  }
}
