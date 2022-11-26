
import 'package:flutter/material.dart';

class toasted extends StatelessWidget {
  //const toasted({Key? key}) : super(key: key);
  final String message;

  toasted(this.message);
  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).primaryColor);
  }
}
