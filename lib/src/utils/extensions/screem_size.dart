import 'package:flutter/material.dart';
// Get Screen Width
double getScreenWidth({ required BuildContext context, double multiplier = 0.0 }) {
  var width = MediaQuery.of(context).size.width;
  if (multiplier != 0.0) {
    width = width * multiplier;
  }

  return width;
}

// Get Screen Height
double getScreenHeight({ required BuildContext context, double multiplier = 0.0 }) {
  var height = MediaQuery.of(context).size.height;
  if (multiplier != 0.0) {
    height = height * multiplier;
  }

  return height;
}