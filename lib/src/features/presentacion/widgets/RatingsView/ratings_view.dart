import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/CardsRating/cards_rating.dart';
import 'package:flutter/material.dart';

class RatingsView extends StatelessWidget {
  List<PlaceRatingEntity> placeRatings;

  RatingsView({Key? key, required this.placeRatings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: _getPlaceRatingsViews(),
        )
      ],
    );
  }

  List<Widget> _getPlaceRatingsViews() {
    return placeRatings.map((placeRating) => CardRatingView(placeRating: placeRating)).toList();
  }
}