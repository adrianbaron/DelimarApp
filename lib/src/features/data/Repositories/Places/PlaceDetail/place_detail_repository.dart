import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';

class DefaultPlaceDetailRepository extends PlaceDetailRepository {

  String _path = "placeList/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultPlaceDetailRepository({ RealtimeDataBaseService? realtimeDataBaseService })
      : _realtimeDataBaseService = realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<void> savePlaceDetail({ required PlaceListDetailEntity placeDetail }) {
    var fullPath = _path + placeDetail.placeId;
    return _realtimeDataBaseService.putData(bodyParameters: placeDetail.toMap(), path: fullPath);
  }
}