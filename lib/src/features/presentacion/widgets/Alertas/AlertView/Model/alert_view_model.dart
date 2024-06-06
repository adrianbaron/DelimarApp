import 'package:flutter/material.dart';

class AlertViewModel {
  final BuildContext context;
  final ImageProvider<Object> imagePath;
  final String headerTitle;
  final String headerSubTitle;
  final String ctaButtonText;
  final String? cancelText;
  final dynamic Function()? ctaButtonAction;
  final void Function()? cancelTextAction;

  AlertViewModel(
      this.context,
      this.imagePath,
      this.headerTitle,
      this.headerSubTitle,
      this.ctaButtonText,
      this.cancelText,
      this.ctaButtonAction,
      this.cancelTextAction);
}
