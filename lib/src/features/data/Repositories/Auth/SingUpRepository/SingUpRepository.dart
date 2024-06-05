import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingUpRepository/singUpRepositoriParams.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Interfaces/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/SingUpDecorable.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Services/SingUpAuthService.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

class DefaultSingUpRepository extends SingUpRepository {
  //Dependencias
  SingUpService _singUpService;

  DefaultSingUpRepository({SingUpService? singUpService})
      : _singUpService = singUpService ?? DefaultSingUpService();
  @override
  Future<Result<SingUpDecorable, Failure>> singUp(
      {required SingUpRepositoriParameters params}) async {
    try {
      final result =
          await _singUpService.signUp(bodyParameters: params.toMap());
      SingUpDecorable decorable = SingUpDecorable.fromJson(result);
      return Result.succes(decorable);
    } on Failure catch (f) {
      return Result.failure(
          Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
