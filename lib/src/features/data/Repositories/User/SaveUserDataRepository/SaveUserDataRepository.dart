import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Decorables/User/UserDecorable.dart';
import 'package:app_delivery/src/features/data/Repositories/User/SaveUserDataRepository/UserBodyParans.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class _Paths {
  static String userCollection = "users/";
}

class DefaultSaveUserDataRepository extends SaveUserDataRepository {
  
  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultSaveUserDataRepository({ RealtimeDataBaseService? realtimeDataBaseService })
          : _realtimeDataBaseService = realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<Result<UserDecodable, Failure>> saveUserData({ required UserBodyParameters params }) async {

    if (params.localId == null) {
      return Result.failure(Failure.fromMessage(message: AppFailureMessages.unExpectedErrorMessage));
    }

    var path = _Paths.userCollection + params.localId!;

    try {
      final result = await _realtimeDataBaseService.putData(
          bodyParameters: params.toMap(), path: path);
      UserDecodable decodable = UserDecodable.fromMap(result);
      return Result.succes(decodable);
    } on Failure catch (f) {
      return Result.failure(f);
    }
  }
}

extension Helper on DefaultSaveUserDataRepository {

}