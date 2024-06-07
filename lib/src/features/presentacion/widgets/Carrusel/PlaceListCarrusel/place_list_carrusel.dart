import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/FavoritesCards/favoriteCard.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/PlaceListCard/place_list_card_view.dart';

import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PlaceListCarrouselStyle { list, listCards }

class PlaceListCarrousel extends StatelessWidget with BaseView {
  final List<PlaceDetailEntity> placeList;
  final bool isShortedVisualization;
  final PlaceListCarrouselStyle carrouselStyle;

  PlaceListCarrousel(
      {Key? key,
      required this.placeList,
      required this.isShortedVisualization,
      required this.carrouselStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount = placeList.length > 3 ? 3 : placeList.length;
    int dynamicHeight =
        isShortedVisualization ? 120 * itemCount : 210 * placeList.length;

    return Container(
        alignment: Alignment.topCenter,
        width: getScreenWidth(context: context),
        height: dynamicHeight.toDouble(),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: isShortedVisualization ? itemCount : placeList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              switch (carrouselStyle) {
                case PlaceListCarrouselStyle.list:
                  return PlaceListCardView(
                      hasFreeDelivery: placeList[index].hasFreeDelivery,
                      placeListDetailEntity: placeList[index]);
                case PlaceListCarrouselStyle.listCards:
                  return FavouritesCardView(
                      isFavourite: placeList[index].isUserFavourite(
                          userUid: MainCoordinator.sharedInstance?.userUid),
                      placeListDetailEntity: placeList[index],
                      delegate: Provider.of<DefaultUserStateProvider>(context));
              }
            }));
  }
}
