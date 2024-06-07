
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/CategoriasCards/collection_grid_card_view.dart';

import 'package:flutter/material.dart';

import '../../../widgets/Headers/text_view.dart';

class CollectionsPage extends StatelessWidget {

  // Dependencies
  List<CollectionDetailEntity> collections;

  CollectionsPage({ Key? key,
                    required this.collections }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              title: const TextView(texto: 'Categoria', fontSize: 17),
              leading: Builder(builder: (BuildContext context) {
                return const BackButtonView(color: Colors.black);
              }),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 30.0, right: 20.0),
              sliver: SliverGrid(
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 mainAxisSpacing: 10.0,
                 crossAxisSpacing: 10.0,
                 crossAxisCount: 2,
                 childAspectRatio: 2
               ),
                delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      return CollectionGridCardView(collection: collections[index]);
                    },
                    childCount: collections.length
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
