import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/PlaceListCarrusel/place_list_carrusel.dart';

import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopularPlacesContentView extends StatelessWidget with BaseView {
  List<PlaceDetailEntity> popularPlaces = [];
  PopularPlacesContentView({Key? key, required this.popularPlaces})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return popularPlaces.isEmpty
        ? Container(height: 20)
        : Column(
            children: [
              GestureDetector(
                  onTap: () => coordinator.showPlaceListPage(
                      context: context, popularPlaces: popularPlaces),
                  child: const HeaderView(
                      textHeader: "Restaurantes de la semana",
                      textAction: "Ver todos")),
              const SizedBox(
                height: 15.0,
              ),
              PlaceListCarrousel(
                  placeList: popularPlaces,
                  isShortedVisualization: true,
                  carrouselStyle: PlaceListCarrouselStyle.list)
            ],
          );
  }
}
