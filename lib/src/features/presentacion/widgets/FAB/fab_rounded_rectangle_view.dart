import 'package:flutter/material.dart';

class FABRoundedRectangleView extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final bool isHidden;
  final ShapeBorder? shape;

  FABRoundedRectangleView(
      {super.key,
      required this.text,
      this.backgroundColor = Colors.orange,
      this.shape = const StadiumBorder(),
      required this.onPressed,
      required this.isHidden});

  @override
  Widget build(BuildContext context) {
    return isHidden
        ? Container()
        : FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            shape: shape,
            label: Text(
              text,
              style:const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ));
  }
}
