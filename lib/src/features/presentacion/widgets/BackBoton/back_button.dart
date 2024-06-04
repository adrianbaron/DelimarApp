import 'package:flutter/material.dart';

class BackButtonView extends StatelessWidget {

  final Color? _color;

  const BackButtonView({super.key,  Color? color }) 
         : _color = color ?? Colors.black;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: _color,
          size: 28.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
