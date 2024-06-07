import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/RatingsView/ratings_view.dart';
import 'package:flutter/material.dart';

class PlaceRatingsPage extends StatelessWidget {
  List<PlaceRatingEntity> placeRatings;

  PlaceRatingsPage({Key? key, required this.placeRatings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        leading: Builder(
          builder: (BuildContext context) {
            return const BackButtonView(color: Colors.black);
          },
        ),
        backgroundColor: Colors.white,
        title: const TextView(
            texto: 'Ratings',
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RatingsView(placeRatings: placeRatings)),
    );
  }
}
