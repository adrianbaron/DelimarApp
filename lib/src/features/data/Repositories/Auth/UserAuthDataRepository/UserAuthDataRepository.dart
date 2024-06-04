import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/data/Decorables/Auth/UserAuthData/UserAuthDataDecorable.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/UserAuthDataRepository/UserAuthDataRepositoryBodyParameters.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Services/GetUserAuthDataService.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

class DefaultUserAuthDataRepository extends UserAuthDataRepository {
  //DEPEMDENCIAS
  final GetUserAuthDataService _getUserAuthDataService;

  DefaultUserAuthDataRepository(
      {GetUserAuthDataService? getUserAuthDataService})
      : _getUserAuthDataService =
            getUserAuthDataService ?? DefaultGetUserAuthDataService();
  @override
  Future<Result<UserAuthDataDecorable, Failure>> getUserAuthData(
      {required GetUserDataBodyParameters parameters}) async {
    try {
      final result = await _getUserAuthDataService.getUserAuthData(
          bodyparameters: parameters.toJson());
      UserAuthDataDecorable _decorable = UserAuthDataDecorable.fromJson(result);
      return Result.succes(_decorable);
    } on Failure catch (f) {
      return Result.failure(
          Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
