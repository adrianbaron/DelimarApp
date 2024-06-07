import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/VerticalCardCarrusel/vertical_card_carrusel.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class NoveltyPlacesContentView extends StatelessWidget {
  //
  List<PlaceDetailEntity> noveltyPlaces = [];

  NoveltyPlacesContentView({super.key, required this.noveltyPlaces});

  @override
  Widget build(BuildContext context) {
    return noveltyPlaces.isEmpty
        ? Container(height: 20)
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                alignment: Alignment.centerLeft,
                child: headerText(
                    texto: 'Descubre nuevos lugares',
                    color: Colors.black,
                    fontSize: 20.0),
              ),
              VerticalCardCarrousel(placeList: noveltyPlaces)
            ],
          );
  }
}
