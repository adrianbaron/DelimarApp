import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/UserAuthData/UserAuthDataUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/UserAuthData/UserAuthDataUseCaseBodyParameters.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class ValidateCurrentUserUseCase {
  Future<bool> execute({required String idToken});
}

class DefaultValidateCurrentUserUseCase extends ValidateCurrentUserUseCase {
  final UserAuthDataUseCase _authDataUseCase;

  DefaultValidateCurrentUserUseCase({UserAuthDataUseCase? authDataUseCase})
      : _authDataUseCase = authDataUseCase ?? DefaultUserAuthDataUseCase();

  @override
  Future<bool> execute({required String idToken}) async {
    try {
      return _authDataUseCase
          .execute(
              parameters: GetUserDataUseCaseBodyParameters(idToken: idToken))
          .then((result) {
        switch (result.status) {
          case ResultStatus.success:
            return true;
          case ResultStatus.error:
            return false;
        }
      });
    } on Failure {
      return false;
    }
  }
}
