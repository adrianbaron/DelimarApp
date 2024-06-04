import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class DoubleTextView extends StatelessWidget {
  final String textHeader;
  final String textAction;
  final VoidCallback? textActionTapped;

  const DoubleTextView({super.key, required this.textHeader, required this.textAction, this.textActionTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
    child: Row(
      children: [
        headerText(texto: textHeader, fontSize: 20.0),
        const Spacer(),
        GestureDetector(
          onTap: textActionTapped,
          child: headerText(
            texto: textAction,
            color:
                Colors.orange, // Asumiendo que 'orange' es una instancia de Color
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
          ),
        ),
      ],
    ),
  );
  }
}

 
  

