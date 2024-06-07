import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class PlaceDetailInfoView extends StatelessWidget {
  PlaceDetailViewModel viewModel;

  PlaceDetailInfoView({ Key? key, required this.viewModel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          margin: const EdgeInsets.symmetric(vertical: 7.0),
          child: Text(viewModel.place.placeName, style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0
          ))
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey),
              const SizedBox(width: 8),
              SizedBox(
                width: 250,
                child: TextView(
                    texto: viewModel.place.address,
                    color: gris,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
