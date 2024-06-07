import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/utils/helpers/UserPhoto/userPhotoHelpers.dart';
import 'package:flutter/material.dart';

class CollectionCardView extends StatelessWidget with BaseView {

  // Dependencies
  CollectionDetailEntity collection;

  CollectionCardView({ Key? key,
                       required this.collection }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              coordinator.showCollectionsDetailPage(context: context,
                                                    collection: collection);
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    width: 300,
                    height: 150,
                    fit: BoxFit.cover,
                    image: NetworkImage(collection?.img ?? DefaultCardImageUrlHelper.defaultCardImageUrl),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    width: 300,
                    height: 150,
                    child: Center(
                        child: Text(collection.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700
                                    ))
                    ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
