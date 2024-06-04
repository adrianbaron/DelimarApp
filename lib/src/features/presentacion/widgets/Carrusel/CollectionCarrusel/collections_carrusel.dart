import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CollectionCarruselView extends StatelessWidget {
  // Dependencies
  List<CollectionDetailEntity> collections = [];

  CollectionCarruselView({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: collections.length < 5 ? collections.length : 5,
          itemBuilder: (BuildContext context, int index) {
            return CollectionCarruselCardView(collection: collections[index]);
          }),
    );
  }
}

class CollectionCarruselCardView extends StatelessWidget with BaseView {
  //DEPENDENCIA
  CollectionDetailEntity collection;
  CollectionCarruselCardView({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      //width: 200,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => coordinator.showCollectionsDetailPage(
                context: context, collection: collection),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    image: NetworkImage(collection.img)),
              ),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.black45),
                child: Center(
                  child: Text(
                    collection.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
