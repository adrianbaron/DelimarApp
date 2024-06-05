import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Repositories/User/SaveUserDataRepository/SaveUserDataRepository.dart';
import 'package:app_delivery/src/features/data/Repositories/User/SaveUserDataRepository/UserBodyParans.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class SaveUserDataUseCase {
  Future<Result<UserEntity, Failure>> execute(
      {required SaveUserDataUseCaseParameters parameters});
}

class DefaultSaveUserDataUseCase extends SaveUserDataUseCase {
  // * Dependencies
  final SaveUserDataRepository _saveUserDataRepository;

  DefaultSaveUserDataUseCase({SaveUserDataRepository? saveUserDataRepository})
      : _saveUserDataRepository =
            saveUserDataRepository ?? DefaultSaveUserDataRepository();

  @override
  Future<Result<UserEntity, Failure>> execute(
      {required SaveUserDataUseCaseParameters parameters}) {
    UserBodyParameters _parameters = UserBodyParameters(
      localId: parameters.localId,
      role: parameters.role?.toShortString(),
      username: parameters.username,
      email: parameters.email,
      phone: parameters.phone,
      dateOfBirth: parameters.dateOfBirth,
      startDate: parameters.startDate,
      photo: parameters.photo,
      shippingAddress: parameters.shippingAddress,
      billingAddress: parameters.billingAddress,
      idToken: parameters.idToken,
      provider: parameters.provider,
    );

    return _saveUserDataRepository
        .saveUserData(params: _parameters)
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          return Result.succes(UserEntity.fromMap(result.value!.toMap()));
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
