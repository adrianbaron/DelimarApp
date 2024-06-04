import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class ListTileCheck extends StatefulWidget {
  final String texto;
  final bool isActive;
  final VoidCallback? func;

  ListTileCheck({
    Key? key,
    required this.texto,
    required this.isActive,
    this.func,
  }) : super(key: key);

  @override
  State<ListTileCheck> createState() => _ListTileCheckState();
}

class _ListTileCheckState extends State<ListTileCheck> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTiles(
            context: context,
            texto: widget.texto,
            isActive: widget.isActive,
            func: widget.func)
      ],
    );
  }
}

Widget ListTiles({
  required BuildContext context,
  String texto = "",
  VoidCallback? func,
  bool isActive = true,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
    ),
    child: ListTile(
      onTap: func,
      title: headerText(
        texto: texto,
        color: isActive ? orange : Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 17.0,
      ),
      trailing: isActive
          ? Icon(
              Icons.check,
              color: isActive ? orange : gris,
            )
          : const Text(''),
    ),
  );
}
