import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingInRepository/SingInBodyParameters.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Interfaces/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/SingInDecorable.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Services/SingInAuthService.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

class DefaultSingInRepository extends SingInRepository {
  //Dependencias
  final SingInService _singInService;

  DefaultSingInRepository({SingInService? singInService})
      : _singInService = singInService ?? DefaultSingInService();

  @override
  Future<Result<SingInDecorable, Failure>> singIn(
      {required SignInBodyParameters params}) async {
    try {
      final result =
          await _singInService.signIn(bodyParameters: params.toMap());
      SingInDecorable decorable = SingInDecorable.fromJson(result);
      return Result.succes(decorable);
    } on Failure catch (f) {
      return Result.failure(
          Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
