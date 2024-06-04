import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/exploreTabViewModel/explore_tab_view_model.dart';
import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/view/Components/collections_content_view.dart';
import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/view/Components/novelty_places_content_view.dart';
import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/view/Components/search_top_bar.dart';
import 'package:flutter/material.dart';

class ExploreTabContentView extends StatelessWidget {
  final ExploreViewModel viewModel;
  ExploreTabContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(children: [
            //
            const SearchTopBar(),
            //
            NoveltyPlacesContentView(noveltyPlaces: viewModel.noveltyPlaces),
            // PopularPlacesContentView(popularPlaces: viewModel.popularPlaces),
            
            const SizedBox(
              height: 40.0,
            ),
            //slider collection
            CollectionContentView(collections: viewModel.collections)
          ]),
        ),
      ]))
    ]);
  }
}



