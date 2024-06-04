import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/AuthFirebaseInterface.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/UpdatePasswordDecorable.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Services/UpdatePasswordUserService.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

class DefaultUpdatePasswordRepository extends UpdatePasswordRepository {
  //DEPENDENCIA
  final UpdatePasswordUserService _updatePasswordUserService;

  DefaultUpdatePasswordRepository(
      {UpdatePasswordUserService? updatePasswordUserService})
      : _updatePasswordUserService =
            updatePasswordUserService ?? DefaultUpdatePasswordUserService();
  @override
  Future<Result<UpdatePasswordDecorable, Failure>> updatePassword(
      {required String email}) async {
    try {
      final result =
          await _updatePasswordUserService.updatePassword(email: email);
      UpdatePasswordDecorable _decorable =
          UpdatePasswordDecorable.fromJson(result);
      return Result.succes(_decorable);
    } on Failure catch (f) {
      return Result.failure(
          Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
