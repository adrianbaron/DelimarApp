import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:flutter/material.dart';

class BookMarkView extends StatelessWidget {
  PlaceDetailViewModel viewModel;

  BookMarkView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: viewModel.isUserFavouritePlaceStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          bool isUserFavourite = snapshot.data ?? false;

          return IconButton(
              icon: Icon(
                isUserFavourite ? Icons.bookmark : Icons.bookmark_border,
                color: isUserFavourite ? rosa : Colors.white,
                size: 30,
              ),
              onPressed: () {
                viewModel.favouriteIconTapped(!isUserFavourite);
              });
        });
  }
}
