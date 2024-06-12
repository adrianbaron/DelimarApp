import 'package:flutter/material.dart';
import '../../Colors/Colors.dart';

// Constants
const _defectBorderRadius = BorderRadius.all(Radius.circular(20));
const _defectBoxShadowObject = [
  BoxShadow(
      color: Color.fromRGBO(210, 211, 215, 1.0),
      offset: Offset(0, 5),
      blurRadius: 10.0)
];

const BorderSide defaultBorderSide = BorderSide(
    color: Colors.orange
);

const BorderSide borderSideTextFieldError = BorderSide(
    color: Colors.red
);

const BorderSide borderSidePaymentCards = BorderSide(
    color: Colors.grey
);

const Decoration defaultTextFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border(top: defaultBorderSide, left: defaultBorderSide, bottom: defaultBorderSide, right: defaultBorderSide)
);

const Decoration borderSideNoneDecoration = BoxDecoration(
    border: Border(bottom: BorderSide.none)
);

const Decoration borderSideNoneGrayBackgroundDecoration = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border(bottom: BorderSide.none)
);

const Decoration borderGrayDecoration = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border(top:borderSidePaymentCards,left: borderSidePaymentCards, right: borderSidePaymentCards, bottom: borderSidePaymentCards)
);

const Decoration errorTextFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border(top: borderSideTextFieldError, left: borderSideTextFieldError, bottom: borderSideTextFieldError, right: borderSideTextFieldError)
);

BoxDecoration getBoxDecorationWithShadows({ BorderRadiusGeometry borderRadius = _defectBorderRadius,
                                            Color containerColor = Colors.white,
                                            List<BoxShadow> boxShadows = _defectBoxShadowObject }) {
  return BoxDecoration(borderRadius: borderRadius, color: containerColor, boxShadow: boxShadows);
}

