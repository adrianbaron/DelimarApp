import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/data/Decorables/User/UserDecorable.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

class DefaultFetchUserDataRepository extends FetchUserDataRepository {
  final String _path = "users/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultFetchUserDataRepository(
      {RealtimeDataBaseService? realtimeDataBaseService})
      : _realtimeDataBaseService =
            realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<Result<UserDecodable, Failure>> fetchUserData(
      {required String localId}) async {
    var fullpath = _path + localId;

    try {
      final result = await _realtimeDataBaseService.getData(path: fullpath);
      return Result.succes(UserDecodable.fromMap(result));
    } on Failure catch (f) {
      return Result.failure(f);
    }
  }
}
