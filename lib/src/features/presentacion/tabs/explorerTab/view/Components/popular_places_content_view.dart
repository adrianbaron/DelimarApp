import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/PlaceListCarrusel/place_list_carrusel.dart';

import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopularPlacesContentView extends StatelessWidget with BaseView {
  //Dependencia
  List<PlaceListDetailEntity> popularPlaces = [];
  PopularPlacesContentView({super.key, required this.popularPlaces});

  @override
  Widget build(BuildContext context) {
    return popularPlaces.isEmpty
        ? Container(height: 20)
        : Column(
            children: [
              GestureDetector(
                  onTap: () = coordinator.showPopularPlacesListView(
                      context: context, popularPlaces: popularPlaces),
                  child: const HeaderView(
                      textHeader: 'Lo mas pedido ',
                      textAction: 'Mostrar todo')),
              const SizedBox(height: 15),
              PlaceListCarrusel(
                  placeList: popularPlaces,
                  isShortedVisualization: true,
                  carrouselStyle: PlaceListCarrouselStyle.list)
            ],
          );
  }
}
