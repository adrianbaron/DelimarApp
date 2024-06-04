import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/tabs/favoriteTab/components/favorite_tab_content_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({Key? key}) : super(key: key);

  @override
  _FavouriteTabState createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavoriteTab>
    with BaseView, FavouritePageChangeStateDelegate {
  @override
  Widget build(BuildContext context) {
    Provider.of<DefaultUserStateProvider>(context)
        .favouritePageChangeStateDelegate = this;

    return Scaffold(
        backgroundColor: gris,
        body: FutureBuilder(
            future: Provider.of<DefaultUserStateProvider>(context)
                .fetchUserFavouritePlaces(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PlaceListDetailEntity>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return loadingView;
                case ConnectionState.done:
                  if (snapshot.hasError || !snapshot.hasData) {
                    return ErrorView();
                  }
                  if (snapshot.hasData) {
                    return FavouriteTabContentView(
                        placeList: snapshot.data ?? []);
                  } else {
                    return Container();
                  }
                default:
                  return loadingView;
              }
            }));
  }

  @override
  placeFromFavouritesRemoved() {
    setState(() {});
  }
}
