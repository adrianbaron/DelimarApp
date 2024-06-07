
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/CategoriasCards/collections_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CollectionsCarrousel extends StatelessWidget {

  // Dependencies
  List<CollectionDetailEntity> collections;
  CollectionsCarrousel({ Key? key,
                         required this.collections }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 180.0,
        child: ListView.builder(
            itemCount: collections.length < 5 ? collections.length : 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return CollectionCardView(collection: collections[index]);
            }));
  }
}
