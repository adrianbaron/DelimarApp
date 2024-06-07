import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:flutter/material.dart';

class ShareIconView extends StatelessWidget {
  PlaceDetailViewModel viewModel;

  ShareIconView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.ios_share,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          // TODO: Add user action
        });
  }
}
