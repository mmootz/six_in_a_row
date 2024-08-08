import 'package:flutter/material.dart';

class ColorPickerScreen extends StatefulWidget {
  static const routeName = 'ColorPicker';
  final Function(Color) onColorSelected;

  ColorPickerScreen({required this.onColorSelected});

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,elevation: 6,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Pick a Color')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(Colors.red);
                  },
                  child: Text(''),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(Colors.green);
                  },
                  child: Text(''),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(Colors.blue);
                  },
                  child: Text(''),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(Colors.purple);
                  },
                  child: Text(''),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(Colors.orange);
                  },
                  child: Text(''),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onColorSelected(Colors.yellow);
                  },
                  child: Text(''),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
