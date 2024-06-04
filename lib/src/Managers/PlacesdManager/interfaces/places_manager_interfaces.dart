import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';

abstract class PlacesManager {
  Future<PlaceListDecorable> fetchPlaceList();
  Future<PlaceListDecorable> fetchNoveltyPlaceList();
  Future<PlaceListDecorable> fetchPopularPlacesList();
  Future<PlaceListDecorable> fetchPlacesListByCategory(
      {required int categoryId});
  Future<PlaceListDecorable> fetchPlacesListByQuery({required String query});
  Future<PlaceListDecorable> fetchPlacesListByRecentSearches(
      {required List<String> placeIds});
}
