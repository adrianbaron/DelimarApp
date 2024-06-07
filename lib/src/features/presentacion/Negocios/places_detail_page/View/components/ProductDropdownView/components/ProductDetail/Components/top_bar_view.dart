import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';

class TopBarView extends StatelessWidget {
  PlaceProductEntity product;

  TopBarView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
            width: double.infinity,
            height: getScreenHeight(context: context, multiplier: 0.42),
            fit: BoxFit.fill,
            image: NetworkImage(product.imgs.first)),
        Container(
          margin: const EdgeInsets.only(top: 56, left: 4),
          child: Row(
            children: [
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.cancel, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Spacer(),
            ],
          ),
        )
      ],
    );
  }
}
