import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:app_delivery/src/utils/helpers/UserPhoto/userPhotoHelpers.dart';
import 'package:flutter/material.dart';

import '../../../../colors/colors.dart';

class PlaceListCardView extends StatelessWidget with BaseView {
  final bool hasFreeDelivery;
  final PlaceListDetailEntity placeListDetailEntity;

  PlaceListCardView(
      {super.key,
      required this.hasFreeDelivery,
      required this.placeListDetailEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        coordinator.showPlaceDetailPage(
            context: context, placeId: placeListDetailEntity.placeId);
      },
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, 'place-detail');
              },
              child: Container(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftImageContentView(
                        imageUrl: placeListDetailEntity.imgs?.first ??
                            DefaultCardImageUrlHelper.defaultCardImageUrl),
                    RightImageContentView(
                        hasFreeDelivery: hasFreeDelivery,
                        placeListDetailEntity: placeListDetailEntity)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class LeftImageContentView extends StatelessWidget {
  //
  final String imageUrl;
  const LeftImageContentView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl)),
    );
  }
}

class RightImageContentView extends StatelessWidget {
  final bool hasFreeDelivery;
  final PlaceListDetailEntity placeListDetailEntity;
  RightImageContentView(
      {super.key,
      required this.hasFreeDelivery,
      required this.placeListDetailEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 300,
      child: Column(
        children: [
          Container(
              width: 250,
              child: Text(
                placeListDetailEntity.placeName,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              )),
          Container(
            width: 250,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(
              placeListDetailEntity.address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: gris, fontWeight: FontWeight.w500, fontSize: 13.0),
            ),
          ),
          Container(
            width: 250,
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: amarillo,
                  size: 16.0,
                ),
                Text("${placeListDetailEntity.ratingAverage}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0)),
                const SizedBox(width: 5),
                Text("(${placeListDetailEntity.ratings} ratngs)",
                    style: TextStyle(
                        color: gris,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0)),
                Transform.translate(
                  offset: const Offset(50, -20),
                  child: SizedBox(
                    width: 120.0,
                    height: 20.0,
                    child: hasFreeDelivery
                        ? createButton(
                            context: context,
                            labelButton: "ab",
                            color: gris,
                            func: () {})
                        : const Text(''),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
