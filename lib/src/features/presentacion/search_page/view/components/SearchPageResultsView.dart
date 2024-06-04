import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/PlaceListCarrusel/place_list_carrusel.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_double.dart';
import 'package:flutter/material.dart';

class SearchPageBuildResultsView extends StatefulWidget {
  // Dependencies
  List<PlaceListDetailEntity> places = [];

  SearchPageBuildResultsView({Key? key, required this.places})
      : super(key: key);

  @override
  State<SearchPageBuildResultsView> createState() =>
      _SearchPageBuildResultsViewState();
}

class _SearchPageBuildResultsViewState extends State<SearchPageBuildResultsView>
    with BaseView {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  const DoubleTextView(
                      textHeader: 'Resultados', textAction: ''),
                  const SizedBox(height: 20.0),
                  PlaceListCarrusel(
                      placeList: widget.places,
                      isShortedVisualization: false,
                      carrouselStyle: PlaceListCarrouselStyle.list)
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
