import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/utils/helpers/UserPhoto/userPhotoHelpers.dart';
import 'package:flutter/material.dart';

class VerticalCardCarrusel extends StatelessWidget {
  final List<PlaceListDetailEntity> placeList;
  VerticalCardCarrusel({super.key, required this.placeList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: placeList.length,
        itemBuilder: (BuildContext context, int index) {
          return VerticalCardView(placeListDetailEntity: placeList[index]);
        },
      ),
    );
  }
}

class VerticalCardView extends StatelessWidget with BaseView {
  //DEPENDENCIA
  final PlaceListDetailEntity placeListDetailEntity;

  VerticalCardView({super.key, required this.placeListDetailEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        coordinator.showPlaceDetailPage(
            context: context, placeId: placeListDetailEntity.placeId);
      },
      child: Container(
        width: 210.0,
        margin: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image(
                    width: 230.0,
                    height: 220.0,
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

                  //margin: EdgeInsets.only(top: 10.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(placeListDetailEntity.address ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: gris,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0)),
                  ),

                  Row(
                    children: [
                      Icon(Icons.star, color: amarillo, size: 16),
                      Text("${placeListDetailEntity.ratingAverage ?? 0.0}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0)),
                      Text("${placeListDetailEntity.ratings ?? 0}",
                          style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0)),
                      Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orangeAccent),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                        color: Colors.orangeAccent),
                                  ),
                                )),
                            child: const Text("Ordenar",
                                style: TextStyle(fontSize: 14.0))),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
