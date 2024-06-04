import 'package:app_delivery/src/features/logica/CasosDeUso/Collections/collections_use_case.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Places/PlaceList/place_list_use_case.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';

import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';

enum ExploreViewModelState { viewLoadedState, errorState }

abstract class ExploreViewModelInput {
  Future<ExploreViewModelState> viewInitState();
  List<PlaceListDetailEntity> noveltyPlaces = [];
  List<PlaceListDetailEntity> popularPlaces = [];
  List<CollectionDetailEntity> collections = [];
}

// Crear ViewModel
abstract class ExploreViewModel extends ExploreViewModelInput {}

class DefaultExploreViewModel extends ExploreViewModel {
  // Dependencies
  final PlaceListUseCase _placeListUseCase;
  final FetchCollectionUseCase _fetchCollectionUseCase;

  DefaultExploreViewModel(
      {PlaceListUseCase? placeListUseCase,
      FetchCollectionUseCase? fetchCollectionUseCase})
      : _placeListUseCase = placeListUseCase ?? DefaultPlaceListUseCase(),
        _fetchCollectionUseCase =
            fetchCollectionUseCase ?? DefaultFetchCollectionUseCase();

  @override
  Future<ExploreViewModelState> viewInitState() async {
    final noveltyPlacesResult = await _placeListUseCase.fetchNoveltyPlaceList();
    noveltyPlaces = noveltyPlacesResult.placeList ?? [];

    final popularPlacesResult =
        await _placeListUseCase.fetchPopularPlacesList();
    popularPlaces = popularPlacesResult.placeList ?? [];

    final collectionsResponse = await _fetchCollectionUseCase.execute();
    collections = collectionsResponse.collections ?? [];

    if (noveltyPlaces.isNotEmpty ||
        popularPlaces.isNotEmpty ||
        collections.isNotEmpty) {
      return ExploreViewModelState.viewLoadedState;
    } else {
      return ExploreViewModelState.errorState;
    }
  }
}
