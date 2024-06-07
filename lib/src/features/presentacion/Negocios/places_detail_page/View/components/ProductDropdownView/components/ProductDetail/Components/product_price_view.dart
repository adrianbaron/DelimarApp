import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:flutter/material.dart';

class ProductPriceView extends StatelessWidget {
  PlaceProductEntity product;

  ProductPriceView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      // Precio del producto
      child: TextView(
          texto: CheckoutHelper.formatPriceInEuros(product.productPrice),
          fontSize: 18,
          fontWeight: FontWeight.w500),
    );
  }
}
