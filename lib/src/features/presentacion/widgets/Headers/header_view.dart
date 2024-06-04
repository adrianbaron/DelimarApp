import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  final String textHeader;
  final String textAction;
  const HeaderView({super.key, required this.textHeader, required this.textAction});

  @override
  Widget build(BuildContext context) {
    return  Row(children: [
    Container(
      alignment: Alignment.centerLeft,
      child: headerText(texto: textHeader, color: Colors.black, fontSize: 20.0),
    ),
    const Spacer(),
    GestureDetector(
      child: Row(
        children: [
          Text(
            textAction,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15.0),
          ),
          const Icon(Icons.play_arrow)
        ],
      ),
    )
  ]);
  }
}
