import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/interfaces/places_manager_interfaces.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/place_manager.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';

class DefaultPlaceListRepository extends PlaceListRepository {
  // * Dependencies
  final PlacesManager _placesManager;

  DefaultPlaceListRepository({PlacesManager? placesManager})
      : _placesManager = placesManager ?? DefaultPlacesManager();

  @override
  Future<PlaceListDecorable> fetchPlaceList() async {
    return _placesManager.fetchPlaceList();
  }

  @override
  Future<PlaceListDecorable> fetchNoveltyPlaceList() {
    return _placesManager.fetchNoveltyPlaceList();
  }

  @override
  Future<PlaceListDecorable> fetchPopularPlacesList() {
    return _placesManager.fetchPopularPlacesList();
  }

  @override
  Future<PlaceListDecorable> fetchPlacesListByCategory(
      {required int categoryId}) {
    return _placesManager.fetchPlacesListByCategory(categoryId: categoryId);
  }

  @override
  Future<PlaceListDecorable> fetchPlacesListByQuery({required String query}) {
    return _placesManager.fetchPlacesListByQuery(query: query);
  }

  @override
  Future<PlaceListDecorable> fetchPlacesListByRecentSearches(
      {required List<String> placeIds}) {
    return _placesManager.fetchPlacesListByRecentSearches(placeIds: placeIds);
  }
}
