import 'package:flutter/material.dart';

class BackButtonView extends StatelessWidget {
  final Color? _color;
  final Function()? _onPressed;

  const BackButtonView({ Color? color, Function()? onPressed }) : _color = color ?? Colors.black, _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: _color,
          size: 28.0,
        ),
        onPressed: _onPressed ?? () {
          Navigator.pop(context);
        });
  }
}
