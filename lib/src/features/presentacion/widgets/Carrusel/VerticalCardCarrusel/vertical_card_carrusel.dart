import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/VerticalCards/NoveltyPlaceVerticalCard/novelty_place_vertical_card_view.dart';

import 'package:flutter/material.dart';

class VerticalCardCarrousel extends StatelessWidget {
  final List<PlaceDetailEntity> placeList;

  const VerticalCardCarrousel({Key? key, required this.placeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 330.0,
        child: ListView.builder(
            itemCount: placeList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return NoveltyPlacesVerticalCardView(
                  placeListDetailEntity: placeList[index]);
            }));
  }
}
