import 'package:animate_do/animate_do.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class PlaceDetailStatsInfoView extends StatelessWidget {
  PlaceDetailViewModel viewModel;

  PlaceDetailStatsInfoView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // widget para mostrar lineas de separacion
    return ElasticIn(
      delay: const Duration(seconds: 2),
      child: Container(
        margin: const EdgeInsets.only(top: 26.0),
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        height: 80.0,
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.red),
                bottom: BorderSide(color: Colors.red))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VerticalStatsView(
                title: "${viewModel.place.ratingAverage}",
                subtitle: "${viewModel.place.ratings} Calificacion",
                icon: Icons.star),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white))),
            ),
            VerticalStatsView(
                title: _getFavouritesCount(),
                subtitle: "Favourites",
                icon: Icons.bookmark),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white))),
            ),
            VerticalStatsView(
                title: viewModel.place.averageDelivery.isEmpty
                    ? "25-30'"
                    : "${viewModel.place.averageDelivery}'",
                subtitle: "Domicilio",
                icon: Icons.punch_clock)
          ],
        ),
      ),
    );
  }

  String _getFavouritesCount() {
    int count = viewModel.place.favourites.length;

    if (count < 1000) {
      return count.toString();
    } else {
      return (count / 1000).toStringAsFixed(1) + 'K';
    }
  }
}

class VerticalStatsView extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String subtitle;

  const VerticalStatsView(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(
            icon,
            color: Colors.white,
            size: 19.0,
          ),
          TextView(
              texto: '${title}',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0)
        ]),
        TextView(
            texto: "${subtitle}",
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15.0)
      ],
    );
  }
}
