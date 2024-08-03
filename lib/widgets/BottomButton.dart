import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  //const BottomButton({Key? key}) : super(key: key);

  final String text;
  final VoidCallback call;

  const BottomButton({Key? key, required this.text, required this.call}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: call,
          child: Card(
            color: Theme
                .of(context).primaryColor,
          elevation: 6,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.87,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                )),
          ),
          ),
        )
      ],
    );
  }
}
