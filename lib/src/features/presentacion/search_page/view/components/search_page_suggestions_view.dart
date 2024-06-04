import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/search_page/ViewModel/search_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/PlaceListCarrusel/place_list_carrusel.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Carrusel/RecentSearchCarrusel/recent_search_carrusel.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_double.dart';
import 'package:flutter/material.dart';

class SearchPageSuggestionsView extends StatefulWidget {
  final String textHeader;
  final String textAction;
  final Function()? textActionTapped;
  final bool isRecentSearchSuggestions;
  final SearchPageViewModel viewModel;

  SearchPageSuggestionsView(
      {Key? key,
      required this.textHeader,
      required this.textAction,
      required this.isRecentSearchSuggestions,
      required this.viewModel,
      this.textActionTapped})
      : super(key: key);

  @override
  State<SearchPageSuggestionsView> createState() =>
      _SearchPageSuggestionsViewState();
}

class _SearchPageSuggestionsViewState extends State<SearchPageSuggestionsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: widget.isRecentSearchSuggestions
            ? SearchPageSuggestionsListView(
                textHeader: widget.textHeader,
                textAction: widget.textAction,
                viewModel: widget.viewModel,
                textActionTapped: () {
                  setState(() {
                    widget.viewModel.clearRecentSearchInLocalStorage();
                  });
                })
            : SearchPageSuggestionsPopularPlacesListView(
                textHeader: widget.textHeader,
                textAction: widget.textAction,
                viewModel: widget.viewModel));
  }
}

class SearchPageSuggestionsListView extends StatelessWidget with BaseView {
  final String textHeader;
  final String textAction;
  final Function()? textActionTapped;
  final SearchPageViewModel viewModel;

  SearchPageSuggestionsListView(
      {Key? key,
      required this.textHeader,
      required this.textAction,
      required this.viewModel,
      this.textActionTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchPlacesListByRecentSearches(),
        builder:
            (BuildContext context, AsyncSnapshot<PlaceListEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView;
            case ConnectionState.done:
              if (snapshot.hasError || !snapshot.hasData) {
                return ErrorView();
              }

              if (snapshot.data?.placeList?.isEmpty ?? false) {
                
                return Container();
              }
             
              return Column(
                children: [
                  const SizedBox(height: 20.0),
                  DoubleTextView(
                      textHeader: textHeader,
                      textAction: textAction,
                      textActionTapped: textActionTapped),
                  RecentSearchCarrouselView(
                    placeList: snapshot.data?.placeList ?? [])
                ],
              );
            default:
              return loadingView;
          }
        });
  }
}

class SearchPageSuggestionsPopularPlacesListView extends StatelessWidget
    with BaseView {
  final String textHeader;
  final String textAction;
  final Function()? textActionTapped;
  final SearchPageViewModel viewModel;

  SearchPageSuggestionsPopularPlacesListView(
      {Key? key,
      required this.textHeader,
      required this.textAction,
      required this.viewModel,
      this.textActionTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchPopularPlacesList(),
        builder:
            (BuildContext context, AsyncSnapshot<PlaceListEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView;
            case ConnectionState.done:
              if (snapshot.hasError || !snapshot.hasData) {
                return ErrorView();
              }
              return CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: [
                          const SizedBox(height: 20.0),
                          DoubleTextView(
                              textHeader: textHeader,
                              textAction: textAction,
                              textActionTapped: textActionTapped),
                          const SizedBox(height: 5.0),
                          Text(
                              'No podemos encontrar el artículo que está buscando, ¿tal vez un pequeño error ortográfico?',
                              style: TextStyle(
                                  color: gris,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0)),
                          const SizedBox(height: 20.0),
                          DoubleTextView(
                              textHeader: "Popolares de la semana",
                              textAction: textAction,
                              textActionTapped: textActionTapped),
                          const SizedBox(height: 20.0),
                          PlaceListCarrusel(
                              placeList: snapshot.data?.placeList ?? [],
                              isShortedVisualization: false,
                              carrouselStyle: PlaceListCarrouselStyle.list)
                        ],
                      )
                    ]),
                  )
                ],
              );
            default:
              return loadingView;
          }
        });
  }
}
