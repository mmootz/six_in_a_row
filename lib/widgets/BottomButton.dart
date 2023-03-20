import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  //const BottomButton({Key? key}) : super(key: key);

  final String text;
  final VoidCallback call;

  BottomButton({required this.text, required this.call});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: call,
          child: Card(
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          elevation: 6,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.87,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                )),
          ),
          ),
        )
      ],
    );
  }
}
