import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/PlaceListCarrusel/place_list_carrusel.dart';
import 'package:flutter/material.dart';

class PopularPlaceListPage extends StatelessWidget {
  List<PlaceListDetailEntity> popularPlaces = [];
  PopularPlaceListPage({super.key, required this.popularPlaces});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        leading: const BackButtonView(color: Colors.white),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  PlaceListCarrusel(
                    placeList: popularPlaces,
                    isShortedVisualization: false,
                    carrouselStyle: PlaceListCarrouselStyle.list,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
