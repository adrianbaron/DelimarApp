import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/rounded_botton.dart';
import 'package:app_delivery/src/utils/helpers/UserPhoto/userPhotoHelpers.dart';
import 'package:flutter/material.dart';

class NoveltyPlacesVerticalCardView extends StatelessWidget with BaseView {
  final PlaceDetailEntity placeListDetailEntity;

  NoveltyPlacesVerticalCardView({Key? key, required this.placeListDetailEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        coordinator.showPlaceDetailPage(
            context: context, place: placeListDetailEntity);
      },
      child: Container(
        width: 250.0,
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                  width: 210.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                  image: NetworkImage(placeListDetailEntity.imgs?.first ??
                      DefaultCardImageUrlHelper.defaultCardImageUrl)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Text(placeListDetailEntity.placeName ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(placeListDetailEntity.address ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0)),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    Text("${placeListDetailEntity.ratingAverage ?? 0.0}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0)),
                    Text("(${placeListDetailEntity.ratings ?? 0.0} ratings)",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0)),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: 80.0,
                        height: 18.0,
                        child: createElevatedButton(
                            shape: const StadiumBorder(),
                            color: Colors.orange,
                            labelColor: Colors.white,
                            labelButton: 'Delivery',
                            labelFontSize: 11.0))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
