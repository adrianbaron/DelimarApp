import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class CollectionGridCardView extends StatelessWidget with BaseView {

  // Dependencies
  CollectionDetailEntity collection;

  CollectionGridCardView({ Key? key,
                            required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          coordinator.showCollectionsDetailPage(context: context,
                                                collection: collection);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                  width: 165,
                  height: 190,
                  fit: BoxFit.cover,
                  image: NetworkImage(collection.img)),
            ),
            Container(
              width: 165,
              height: 190,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Center(
              child: TextView(
                  texto: collection.name ?? "",
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}