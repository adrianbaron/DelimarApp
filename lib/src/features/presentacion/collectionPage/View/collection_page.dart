import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  //Dependencias
  List<CollectionDetailEntity> collections;
  CollectionPage({required this.collections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            title: headerText(texto: 'Categorias del mar', fontSize: 17),
            centerTitle: true,
            leading: Builder(builder: (BuildContext context) {
              return const BackButtonView(color: Colors.black);
            }),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(left: 25.0, right: 10.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    childAspectRatio: 2),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CollectionGridCardView(collection: collections[index]);
                }, childCount: collections.length),
              ))
        ],
      ),
    );
  }
}

class CollectionGridCardView extends StatelessWidget with BaseView {
  //Dependencia
  CollectionDetailEntity collection;

  CollectionGridCardView({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, 'collectionDetail');
        coordinator.showCollectionsDetailPage(
            context: context, collection: collection);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              width: 165,
              height: 190,
              fit: BoxFit.cover,
              image: NetworkImage(collection.img),
            ),
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
              child: headerText(
                  texto: collection.name,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18))
        ],
      ),
    );
  }
}
