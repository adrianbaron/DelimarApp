import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';

abstract class PlaceDetailRepository {
  Future<void> savePlaceDetail({required PlaceDetailDecodable placeDetail});
  Future<PlaceDetailDecodable> fetchPlaceDetail({required String placeId});
}

class DefaultPlaceDetailRepository extends PlaceDetailRepository {
  final String _path = "placeList/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultPlaceDetailRepository(
      {RealtimeDataBaseService? realtimeDataBaseService})
      : _realtimeDataBaseService =
            realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<PlaceDetailDecodable> fetchPlaceDetail(
      {required String placeId}) async {
    try {
      final response =
          await _realtimeDataBaseService.getData(path: _path + placeId);
      return PlaceDetailDecodable.fromMap(response);
    } on Failure catch (f) {
      return Future.error(f);
    }
  }

  @override
  Future<void> savePlaceDetail({required PlaceDetailDecodable placeDetail}) {
    return _realtimeDataBaseService.putData(
        bodyParameters: placeDetail.toMap(), path: _path + placeDetail.placeId);
  }
}
