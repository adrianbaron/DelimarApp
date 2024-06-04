import 'package:app_delivery/src/features/logica/CasosDeUso/Places/PlaceList/place_list_use_case.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';

enum CollectionDetailPageViewState {
  viewLoadedState,
  errorState,
}

abstract class CollectionDetailPageViewModelInput {
  Future<CollectionDetailPageViewState> viewInitialState();
  CollectionDetailEntity getCollection();
  List<PlaceListDetailEntity> filteredPlacesByCategory = [];
}

abstract class CollectionDetailPageViewModel
    extends CollectionDetailPageViewModelInput {}

class DefaultCollectionDetailPageViewModel
    extends CollectionDetailPageViewModel {
  // Dependencies
  CollectionDetailEntity collection;
  final PlaceListUseCase _placeListUseCase;

  DefaultCollectionDetailPageViewModel(
      {required this.collection, PlaceListUseCase? placeListUseCase})
      : _placeListUseCase = placeListUseCase ?? DefaultPlaceListUseCase();

  @override
  CollectionDetailEntity getCollection() {
    return collection;
  }

  @override
  Future<CollectionDetailPageViewState> viewInitialState() async {
    final placeResult = await _placeListUseCase.fetchPlacesListByCategory(categoryId: collection.id);
    filteredPlacesByCategory = placeResult.placeList ?? [];
    return CollectionDetailPageViewState.viewLoadedState;
  }
}
