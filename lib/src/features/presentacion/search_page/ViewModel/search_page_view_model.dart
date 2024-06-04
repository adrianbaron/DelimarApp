import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/FetchLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/SaveLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Places/PlaceList/place_list_use_case.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';

abstract class SearchPageViewModelInput {
  Future<PlaceListEntity> fetchPlacesListByQuery({required String query});
  Future<PlaceListEntity> fetchPlacesListByRecentSearches();
  Future<PlaceListEntity> fetchPopularPlacesList();
  Future<void> clearRecentSearchInLocalStorage();
}

abstract class SearchPageViewModel extends SearchPageViewModelInput {}

class DefaultSearchPageViewModel extends SearchPageViewModel {
  // Dependencies
  final PlaceListUseCase _placeListUseCase;
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  DefaultSearchPageViewModel(
      {PlaceListUseCase? placeListUseCase,
      FetchLocalStorageUseCase? fetchLocalStorageUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _placeListUseCase = placeListUseCase ?? DefaultPlaceListUseCase(),
        _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  @override
  Future<void> clearRecentSearchInLocalStorage() {
    return _saveLocalStorageUseCase.clearRecentSearchInLocalStorage();
  }

  @override
  Future<PlaceListEntity> fetchPlacesListByQuery({required String query}) {
    return _placeListUseCase.fetchPlacesListByQuery(query: query);
  }

  @override
  Future<PlaceListEntity> fetchPlacesListByRecentSearches() async {
    final placeIds = await _fetchLocalStorageUseCase.fetchRecentSearches();
    return _placeListUseCase.fetchPlacesListByRecentSearches(
        placeIds: placeIds);
  }

  @override
  Future<PlaceListEntity> fetchPopularPlacesList() {
    return _placeListUseCase.fetchPopularPlacesList();
  }
}
