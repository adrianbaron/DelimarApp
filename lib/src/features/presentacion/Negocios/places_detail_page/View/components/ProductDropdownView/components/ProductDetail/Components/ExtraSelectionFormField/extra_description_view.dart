import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class ExtraDescriptionView extends StatelessWidget {
  PlaceProductExtrasEntity extra;

  ExtraDescriptionView({ super.key, required this.extra });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      // Texto elegido por el admin + nombre del producto
      child: TextView(
          texto: extra.title,
          fontSize: 16,
          fontWeight: FontWeight.w700),
    );
  }
}