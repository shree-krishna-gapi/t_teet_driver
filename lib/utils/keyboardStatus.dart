import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
class KeyboardStatus extends StatefulWidget {
  KeyboardStatus({this.minHeight,this.maxHeight});
  final double minHeight;
  final double maxHeight;

  @override
  _KeyboardStatusState createState() => _KeyboardStatusState();
}

class _KeyboardStatusState extends State<KeyboardStatus> {
  bool keyboard;
  @override
  void initState() {
    keyboard = KeyboardVisibility.isVisible;
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        keyboard = visible;
      });
      print(visible);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: keyboard ? widget.minHeight :widget.maxHeight,
      width: double.infinity,
      duration: Duration(milliseconds: 300),
    );
  }
}
