import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/UserAuthDataRepository/UserAuthDataRepository.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/UserAuthDataRepository/UserAuthDataRepositoryBodyParameters.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/UserAuthData/UserAuthDataUseCaseBodyParameters.dart';

import 'package:app_delivery/src/features/logica/Entidades/Auth/UserAuthData/UserAuthDataEntity.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class UserAuthDataUseCase {
  Future<Result<UserAuthDataEntity, Failure>> execute(
      {required GetUserDataUseCaseBodyParameters parameters});
}

class DefaultUserAuthDataUseCase extends UserAuthDataUseCase {
  //DEPENDENCIA
  final UserAuthDataRepository _userAuthDataRepository;

  DefaultUserAuthDataUseCase({UserAuthDataRepository? userAuthDataRepository})
      : _userAuthDataRepository =
            userAuthDataRepository ?? DefaultUserAuthDataRepository();
  @override
  Future<Result<UserAuthDataEntity, Failure>> execute(
      {required GetUserDataUseCaseBodyParameters parameters}) {
    return _userAuthDataRepository
        .getUserAuthData(
            parameters: GetUserDataBodyParameters(idToken: parameters.idToken))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          return Result.succes(
              UserAuthDataEntity.fromJson(result.value!.toJson()));
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
