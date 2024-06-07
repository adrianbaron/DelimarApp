import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/interfaces/places_manager_interfaces.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/place_manager.dart';


abstract class PlaceListRepository {
  Future<PlaceListDecodable> fetchPlaceList();
  Future<PlaceListDecodable> fetchNoveltyPlaceList();
  Future<PlaceListDecodable> fetchPopularPlacesList();
  Future<PlaceListDecodable> fetchPlacesListByCategory({ required int categoryId });
  Future<PlaceListDecodable> fetchPlacesListByQuery({ required String query });
  Future<PlaceListDecodable> fetchPlacesListByRecentSearches({ required List<String> placeIds });
}

class DefaultPlaceListRepository extends PlaceListRepository {
  
  // * Dependencies
  final PlacesManager _placesManager;

  DefaultPlaceListRepository({ PlacesManager? placesManager })
        : _placesManager = placesManager ?? DefaultPlacesManager();

  @override
  Future<PlaceListDecodable> fetchPlaceList() async {
    return _placesManager.fetchPlaceList();
  }

  @override
  Future<PlaceListDecodable> fetchNoveltyPlaceList() {
    return _placesManager.fetchNoveltyPlaceList();
  }

  @override
  Future<PlaceListDecodable> fetchPopularPlacesList() {
    return _placesManager.fetchPopularPlacesList();
  }

  @override
  Future<PlaceListDecodable> fetchPlacesListByCategory({ required int categoryId }) {
    return _placesManager.fetchPlacesListByCategory(categoryId: categoryId);
  }

  @override
  Future<PlaceListDecodable> fetchPlacesListByQuery({ required String query }) {
    return _placesManager.fetchPlacesListByQuery(query: query);
  }

  @override
  Future<PlaceListDecodable> fetchPlacesListByRecentSearches({ required List<String> placeIds }) {
    return _placesManager.fetchPlacesListByRecentSearches(placeIds: placeIds);
  }
}