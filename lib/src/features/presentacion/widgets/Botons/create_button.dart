import 'package:app_delivery/src/colors/colors.dart';
import 'package:flutter/material.dart';

Widget createButton({
  required BuildContext context,
  double width = 350.0,
  double height = 45.0,
  double radius = 20.0,
  bool isWithIcon = false,
  ImageProvider<Object>? icon,
  required String labelButton,
  required Color color,
  OutlinedBorder shape = const StadiumBorder(),
  required VoidCallback func,
}) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.only(top: 20.0),
    child: isWithIcon
        ? _buttonWithIcon(radius, icon!, labelButton, color, shape, func)
        : _buttonNotIcon(radius, labelButton, color, shape, func),
  );
}

Widget _buttonWithIcon(
  double radius,
  ImageProvider<Object> icon,
  String labelButton,
  Color color,
  OutlinedBorder shape,
  VoidCallback func,
) {
  return ElevatedButton(
    onPressed: func,
    style: ElevatedButton.styleFrom(
      shape: shape,
      backgroundColor: color,
      padding: EdgeInsets.zero,
    ),
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: icon,
              width: 20.0,
              height: 20.0,
            ),
            const SizedBox(width: 10.0),
            Text(
              labelButton,
              style: const TextStyle(color: Colors.orange, fontSize: 13.0),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buttonNotIcon(
  double radius,
  String labelButton,
  Color color,
  OutlinedBorder shape,
  VoidCallback func,
) {
  return ElevatedButton(
    onPressed: func,
    style: ElevatedButton.styleFrom(
      shape: shape,
      backgroundColor: color,
      padding: EdgeInsets.zero,
    ),
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          labelButton,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    ),
  );
}
