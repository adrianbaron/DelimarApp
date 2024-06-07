import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/PlaceListCarrusel/place_list_carrusel.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';


import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CollectionDetailPageContentView extends StatelessWidget {
  CollectionDetailEntity collection;
  List<PlaceDetailEntity> filteredPlacesByCategory;

  CollectionDetailPageContentView(
      {Key? key,
      required this.collection,
      required this.filteredPlacesByCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: getScreenHeight(context: context, multiplier: 0.2),
          backgroundColor: orange,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Image(
                    width: double.infinity,
                    height: getScreenHeight(context: context, multiplier: 0.3),
                    fit: BoxFit.cover,
                    image: NetworkImage(collection.img)),
                Container(
                    decoration: const BoxDecoration(color: Colors.black45),
                    width: double.infinity,
                    height: getScreenHeight(context: context, multiplier: 0.3)),
                Center(
                  child: TextView(
                      texto: collection.name,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      textAlign: TextAlign.center),
                )
              ],
            ),
          ),
          leading: Builder(builder: (BuildContext context) {
            return const BackButtonView(color: Colors.white);
          }),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextView(
                      texto: "${filteredPlacesByCategory.length} places",
                      color: const Color.fromRGBO(51, 58, 77, 1.0),
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
                Transform.translate(
                  offset: const Offset(0, -70),
                  child: PlaceListCarrousel(
                      placeList: filteredPlacesByCategory,
                      isShortedVisualization: false,
                      carrouselStyle: PlaceListCarrouselStyle.listCards),
                )
              ],
            ),
          )
        ]))
      ],
    );
  }
}
