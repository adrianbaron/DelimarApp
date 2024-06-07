import 'package:app_delivery/src/features/logica/CasosDeUso/Places/FavoritePlacesUseCase/favorite_places_use_case.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Places/PlaceList/place_list_use_case.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';

enum CollectionDetailPageViewState { viewLoadedState }

abstract class CollectionDetailPageViewModelInput {
  Future<CollectionDetailPageViewState> viewInitState();
  CollectionDetailEntity getCollection();
  List<PlaceDetailEntity> filteredPlacesByCategory = [];
}

abstract class CollectionDetailPageViewModel extends CollectionDetailPageViewModelInput {}

class DefaultCollectionDetailPageViewModel extends CollectionDetailPageViewModel {
  // Dependencies
  CollectionDetailEntity collection;
  final PlaceListUseCase _placeListUseCase;
  final FavouritesPlacesUseCase _favouritesPlacesUseCase;

  DefaultCollectionDetailPageViewModel({ required this.collection,
                                         PlaceListUseCase? placeListUseCase,
                                         FavouritesPlacesUseCase? favouritesPlacesUseCase })
      : _placeListUseCase = placeListUseCase ?? DefaultPlaceListUseCase(),
        _favouritesPlacesUseCase = favouritesPlacesUseCase ?? DefaultFavouritesPlacesUseCase();

  @override
  Future<CollectionDetailPageViewState> viewInitState() async {
    final placesResult = await _placeListUseCase.fetchPlacesListByCategory(
        categoryId: collection.id);
    filteredPlacesByCategory = placesResult.placeList ?? [];
    return CollectionDetailPageViewState.viewLoadedState;
  }

  CollectionDetailEntity getCollection() {
    return collection;
  }
}
