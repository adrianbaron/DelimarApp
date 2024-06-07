import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';

abstract class PlacesManager {
  Future<PlaceListDecodable> fetchPlaceList();
  Future<PlaceListDecodable> fetchNoveltyPlaceList();
  Future<PlaceListDecodable> fetchPopularPlacesList();
  Future<PlaceListDecodable> fetchPlacesListByCategory(
      {required int categoryId});
  Future<PlaceListDecodable> fetchPlacesListByQuery({required String query});
  Future<PlaceListDecodable> fetchPlacesListByRecentSearches(
      {required List<String> placeIds});
}
