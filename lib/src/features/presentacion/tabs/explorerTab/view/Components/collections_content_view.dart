import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/CollectionCarrusel/collections_carrusel.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_view.dart';
import 'package:flutter/material.dart';

class CollectionContentView extends StatelessWidget with BaseView {
  // Dependencies
  List<CollectionDetailEntity> collections = [];
  CollectionContentView({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return collections.isEmpty
        ? Container(height: 10)
        : Column(
            children: [
              GestureDetector(
                  onTap: () {
                    coordinator.showCollectionsPage(
                        context: context, collections: collections);
                  },
                  child: const HeaderView(
                      textHeader: 'Categorias', textAction: 'Mostrar todo')),
              CollectionCarruselView(collections: collections)
            ],
          );
  }
}
