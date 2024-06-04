import 'package:app_delivery/src/features/data/Decorables/Collections/CollectionsDecorable.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';

class DefaultCollectionsRepository extends CollectionsRepository {

  String _path = "collections/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;
  
  DefaultCollectionsRepository({ RealtimeDataBaseService? realtimeDataBaseService })
          : _realtimeDataBaseService = realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<CollectionsDecodable> fetchCollections() async {
    final response = await _realtimeDataBaseService.getData(path: _path);
    CollectionsDecodable decodable = CollectionsDecodable.fromMap(response);
    return decodable;
  }
}

