import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/search_page/ViewModel/search_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/search_page/view/components/SearchPageResultsView.dart';
import 'package:app_delivery/src/features/presentacion/search_page/view/components/search_page_suggestions_view.dart';
import 'package:flutter/material.dart';

class SearchPage extends SearchDelegate with BaseView {
  //Dependencias
  final SearchPageViewModel viewModel;

  SearchPage({SearchPageViewModel? searchPageViewModel})
      : viewModel = searchPageViewModel ?? DefaultSearchPageViewModel();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
        // Use this to change the query's text style
        titleLarge: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.orange,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        // Use this change the placeholder's text style
        hintStyle: TextStyle(fontSize: 18.0),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchPlacesListByQuery(query: query),
        builder:
            (BuildContext context, AsyncSnapshot<PlaceListEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView;
            case ConnectionState.done:
              if (snapshot.hasError || !snapshot.hasData) {
                return ErrorView();
              }
              if (snapshot.data?.placeList?.isEmpty ?? true) {
                return SearchPageSuggestionsView(
                    textHeader: 'Sin resultados',
                    textAction: '',
                    isRecentSearchSuggestions: false,
                    viewModel: viewModel);
              } else {
                return SearchPageBuildResultsView(
                    places: snapshot.data?.placeList ?? []);
              }
            default:
              return loadingView;
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return SearchPageSuggestionsView(
          textHeader: 'Visto recientemente',
          textAction: 'Limpiar',
          isRecentSearchSuggestions: true,
          viewModel: viewModel);
    } else {
      // TODO: Implementar sugerencias de búsqueda en base a la query
      return Container();
    }
  }
}
