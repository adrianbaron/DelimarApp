import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/VerticalCards/BusquedaRecientes/recent_search_vertical_card.dart';
import 'package:flutter/material.dart';
class RecentSearchCarrouselView extends StatelessWidget {
  // Dependencies
  final List<PlaceDetailEntity> placeList;
  RecentSearchCarrouselView({ Key? key, required this.placeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5.0),
        height: 240.0,
        child: ListView.builder(
          itemCount: placeList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return RecentSearchVerticalCardView(placeListDetailEntity: placeList[index]);
          },
        ));
  }
}
