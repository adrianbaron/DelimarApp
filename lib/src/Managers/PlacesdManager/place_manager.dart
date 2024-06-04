import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/interfaces/places_manager_interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';
import 'package:app_delivery/src/services/GeolocationService/Interface/GeolocationServiceInterfaces.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/GeolocationServiceHelper.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/MockGeolocationService.dart';

class DefaultPlacesManager extends PlacesManager {
  String placeListPath = "placeList/";
  double distanceRange = 10.0;

  // Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;
  final GeolocationService _geolocationService;
  final GeolocationServiceHelper _geolocationHelpersService;

  DefaultPlacesManager(
      {RealtimeDataBaseService? realtimeDataBaseService,
      GeolocationService? geolocationService,
      GeolocationServiceHelper? geolocationHelpersService})
      : _realtimeDataBaseService =
            realtimeDataBaseService ?? DefaultRealtimeDatabaseService(),
        _geolocationService = geolocationService ??
            MockGeolocationService(), // Bueno: DefaultGeolocationService() Mock: MockSuccessGeolocationService
        _geolocationHelpersService =
            geolocationHelpersService ?? DefaultGeolocatiionServiceHelper();

  @override
  Future<PlaceListDecorable> fetchPlaceList() async {
    try {
      final response =
          await _realtimeDataBaseService.getData(path: placeListPath);
      
      final userPosition = await _geolocationService.getCurrentPosition();
      PlaceListDecorable decodable =
          _mapToPlaceListDecodable(response: response);
      decodable.placeList = _mapNearPlaceList(
          placeList: decodable.placeList ?? [],
          userLat: userPosition.value?.latitude ?? 0.0,
          userLng: userPosition.value?.longitude ?? 0.0);

      //print("Lista de lugares: ${decodable}");
      //print("Respuesta de la base de datos: $response");
      return decodable;
    } on Failure catch (f) {
      return Future.error(f);
    }
  }

  @override
  Future<PlaceListDecorable> fetchNoveltyPlaceList() async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList =
        _mapNoveltyPlaceList(placeList: fullPlaceList.placeList ?? []);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecorable> fetchPopularPlacesList() async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList =
        _mapPopularPlaceList(placeList: fullPlaceList.placeList ?? []);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecorable> fetchPlacesListByCategory(
      {required int categoryId}) async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapPlaceListByCategory(
        placeList: fullPlaceList.placeList ?? [], categoryId: categoryId);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecorable> fetchPlacesListByQuery(
      {required String query}) async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapPlaceListByQuery(
        placeList: fullPlaceList.placeList ?? [], query: query);
    return fullPlaceList;
  }

  @override
  Future<PlaceListDecorable> fetchPlacesListByRecentSearches(
      {required List<String> placeIds}) async {
    final fullPlaceList = await fetchPlaceList();
    fullPlaceList.placeList = _mapPlaceListByRecentSearches(
        placeList: fullPlaceList.placeList ?? [], placeIds: placeIds);
    return fullPlaceList;
  }
}

extension Mappers on DefaultPlacesManager {
  PlaceListDecorable _mapToPlaceListDecodable(
      {required Map<String, dynamic> response}) {
    List<PlaceList>? placeList = [];
    response.forEach((key, value) {
      placeList.add(PlaceList.fromMap(value));
    });
    return PlaceListDecorable(placeList: placeList);
  }

  List<PlaceList> _mapNearPlaceList(
      {required List<PlaceList> placeList,
      required double userLat,
      required double userLng}) {
    List<PlaceList> placeListFiltered = [];
    placeList.forEach((place) {
      double distance =
          _geolocationHelpersService.getDistanceBetweenInKilometers(
              userLat, userLng, place.lat, place.long);
      // TODO: Puedes filtrar por los activos de esta manera -> && place.status == "active"
      // En mi caso no lo haré aquí, luego haremos otra feature 😉
      if (distance <= distanceRange) {
        placeListFiltered.add(place);
      }
    });
    return placeListFiltered;
  }

  List<PlaceList> _mapNoveltyPlaceList({required List<PlaceList> placeList}) {
    List<PlaceList> placeListFiltered = [];
    placeList.forEach((place) {
      if (place.isNovelty) {
        placeListFiltered.add(place);
      }
    });
    return placeListFiltered;
  }

  List<PlaceList> _mapPopularPlaceList({required List<PlaceList> placeList}) {
    List<PlaceList> placeListFiltered = [];
    placeList.forEach((place) {
      if (place.isPopularThisWeek) {
        placeListFiltered.add(place);
      }
    });
    return placeListFiltered;
  }

  List<PlaceList> _mapPlaceListByCategory(
      {required List<PlaceList> placeList, required int categoryId}) {
    List<PlaceList> placeListFiltered = [];
    placeList.forEach((place) {
      if (place.collectionId == categoryId) {
        placeListFiltered.add(place);
      }
    });
    return placeListFiltered;
  }

  List<PlaceList> _mapPlaceListByQuery(
      {required List<PlaceList> placeList, required String query}) {
    List<PlaceList> placeListFiltered = [];
    placeList.forEach((place) {
      if (query.isNotEmpty &&
          place.placeName.toLowerCase().contains(query.toLowerCase())) {
        placeListFiltered.add(place);
      }
    });
    return placeListFiltered;
  }

  List<PlaceList> _mapPlaceListByRecentSearches(
      {required List<PlaceList> placeList, required List<String> placeIds}) {
    List<PlaceList> placeListFiltered = [];
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
