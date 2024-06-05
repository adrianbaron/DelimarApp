import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/PlaceListCarrusel/place_list_carrusel.dart';
import 'package:flutter/material.dart';

class FavouriteTabContentView extends StatelessWidget {
  List<PlaceListDetailEntity> placeList;

  FavouriteTabContentView({Key? key, required this.placeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: const Text(''),
          backgroundColor: Colors.white,
          title: Text(
            'Mis favoritos',
            style: TextStyle(
                color: const ColorScheme.dark().onSecondary,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: PlaceListCarrusel(
                placeList: placeList,
                isShortedVisualization: false,
                carrouselStyle: PlaceListCarrouselStyle.listCards),
          )
        ]))
      ],
    );
  }
}
