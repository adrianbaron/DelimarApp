import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/interfaces/places_manager_interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';
import 'package:app_delivery/src/services/GeolocationService/Interface/GeolocationServiceInterfaces.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/GeolocationServiceHelper.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/MockGeolocationService.dart';

class DefaultPlacesManager extends PlacesManager {
   String placeListPath = "placeList";
   double distanceRange = 10.0;

  // Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;
  final GeolocationService _geolocationService;
  final GeolocationServiceHelper _geolocationHelpersService;

  DefaultPlacesManager({ RealtimeDataBaseService? realtimeDataBaseService,
                         GeolocationService? geolocationService,
                         GeolocationServiceHelper? geolocationHelpersService})
      : _realtimeDataBaseService = realtimeDataBaseService ?? DefaultRealtimeDatabaseService(),
        _geolocationService = geolocationService ?? MockGeolocationService(),// Bueno: DefaultGeolocationService() Mock: MockSuccessGeolocationService
        _geolocationHelpersService = geolocationHelpersService ?? DefaultGeolocatiionServiceHelper();

  @override
  Future<PlaceListDecodable> fetchPlaceList() async {
    try {
      final response = await _realtimeDataBaseService.getData(path: placeListPath);
      final userPosition = await _geolocationService.getCurrentPosition();
      PlaceListDecodable decodable = _mapToPlaceListDecodable(response: response);
      decodable.placeList = _mapNearPlaceList(placeList: decodable.placeList ?? [],
                                              userLat: userPosition.value?.latitude ?? 0.0,
                                              userLng: userPosition.value?.longitude ?? 0.0);
      return decodable;
    } on Failure catch (f) {
      return Future.error(f);
    }
  }

  @override
  Future<PlaceListDecodable> fetchNoveltyPlaceList() async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapNoveltyPlaceList(placeList: fullPlaceList.placeList ?? []);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecodable> fetchPopularPlacesList() async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapPopularPlaceList(placeList: fullPlaceList.placeList ?? []);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecodable> fetchPlacesListByCategory({ required int categoryId }) async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapPlaceListByCategory(placeList: fullPlaceList.placeList ?? [],
                                                      categoryId: categoryId);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecodable> fetchPlacesListByQuery({ required String query }) async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapPlaceListByQuery(placeList: fullPlaceList.placeList ?? [],
                                                   query: query);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecodable> fetchPlacesListByRecentSearches({ required List<String> placeIds }) async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapPlaceListByRecentSearches(placeList: fullPlaceList.placeList ?? [],
                                                            placeIds: placeIds);
    return fullPlaceList;
  }
}

extension Mappers on DefaultPlacesManager {
    PlaceListDecodable _mapToPlaceListDecodable({ required Map<String, dynamic> response }) {
      List<PlaceDetailDecodable>? placeList = [];
      response.forEach((key, value) {
        placeList.add(PlaceDetailDecodable.fromMap(value));
      });
      return PlaceListDecodable(placeList: placeList);
    }

    List<PlaceDetailDecodable> _mapNearPlaceList({ required List<PlaceDetailDecodable> placeList,
                                        required double userLat,
                                        required double userLng }) {
      List<PlaceDetailDecodable> placeListFiltered = [];
      placeList.forEach( (place) {
        double distance = _geolocationHelpersService.getDistanceBetweenInKilometers(userLat, userLng, place.lat, place.long);
        // TODO: Puedes filtrar por los activos de esta manera -> && place.status == "active"
        // En mi caso no lo haré aquí, luego haremos otra feature 😉
        if (distance <= distanceRange) {
          placeListFiltered.add(place);
        }
      });
      return placeListFiltered;
    }

    List<PlaceDetailDecodable> _mapNoveltyPlaceList({ required List<PlaceDetailDecodable> placeList }) {
      List<PlaceDetailDecodable> placeListFiltered = [];
      placeList.forEach( (place) {
        if (place.isNovelty) {
          placeListFiltered.add(place);
        }
      });
      return placeListFiltered;
   }

    List<PlaceDetailDecodable> _mapPopularPlaceList({ required List<PlaceDetailDecodable> placeList }) {
      List<PlaceDetailDecodable> placeListFiltered = [];
      placeList.forEach( (place) {
        if (place.isPopularThisWeek) {
          placeListFiltered.add(place);
        }
      });
      return placeListFiltered;
    }

    List<PlaceDetailDecodable> _mapPlaceListByCategory({ required List<PlaceDetailDecodable> placeList,
                                              required int categoryId }) {
      List<PlaceDetailDecodable> placeListFiltered = [];
      placeList.forEach( (place) {
        if (place.collectionId == categoryId ) {
          placeListFiltered.add(place);
        }
      });
      return placeListFiltered;
    }

    List<PlaceDetailDecodable> _mapPlaceListByQuery({ required List<PlaceDetailDecodable> placeList,
                                           required String query }) {
      List<PlaceDetailDecodable> placeListFiltered = [];
      placeList.forEach((place) {
        if (query.isNotEmpty && place.placeName.toLowerCase().contains(query.toLowerCase()) ) {
          placeListFiltered.add(place);
        }
      });
      return placeListFiltered;
    }

    List<PlaceDetailDecodable> _mapPlaceListByRecentSearches({ required List<PlaceDetailDecodable> placeList,
                                                    required List<String> placeIds }) {
      List<PlaceDetailDecodable> placeListFiltered = [];
      for (var placeId in placeIds) {
        placeList.forEach((place) {
          if (place.placeId == placeId) {
            placeListFiltered.add(place);
          }
        });
      }
      return placeListFiltered;
    }
}