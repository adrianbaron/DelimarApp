import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/presentacion/Collection_detail_page/View/Components/collection_detail_page_content_view.dart';
import 'package:app_delivery/src/features/presentacion/Collection_detail_page/ViewModel/collections_detail_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:flutter/material.dart';

class CollectionDetailPage extends StatelessWidget with BaseView {
  final CollectionDetailPageViewModel viewModel;

  CollectionDetailPage(
      {required CollectionDetailPageViewModel collectionDetailPageViewModel})
      : viewModel = collectionDetailPageViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: viewModel.viewInitialState(),
          builder: (BuildContext context,
              AsyncSnapshot<CollectionDetailPageViewState> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return loadingView;

              case ConnectionState.done:
                //

                switch (snapshot.data) {
                  case CollectionDetailPageViewState.viewLoadedState:
                    return CollectionDetailPageContentView(
                        collection: viewModel.getCollection(),
                        filteredPlacesByCategory:
                            viewModel.filteredPlacesByCategory);
                  default:
                    return ErrorView();
                }
              default:
                return loadingView;
            }
          }),
    );
  }
}
