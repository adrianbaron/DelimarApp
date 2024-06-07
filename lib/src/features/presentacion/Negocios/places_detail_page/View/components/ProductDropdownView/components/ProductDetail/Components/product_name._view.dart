import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class ProductNameView extends StatelessWidget {
  PlaceProductEntity product;
  
  ProductNameView({super.key, required this.product });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      // Nombre del producto
      child: TextView(texto: product.productName, fontSize: 18),
    );
  }
}