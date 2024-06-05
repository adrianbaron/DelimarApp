import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingUpRepository/SingUpRepository.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingUpRepository/singUpRepositoriParams.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingUpUseCase/SingUpUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/Auth/SingUpEntity/SingUpEntity.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/utils/helpers/Dates/datesHelpers.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:app_delivery/src/utils/helpers/UserPhoto/userPhotoHelpers.dart';

abstract class SingUpUseCase {
  Future<Result<SingUpEntity, Failure>> execute(
      {required SingUpUseCaseParameters params});
}

class DefaultSingUpUseCase extends SingUpUseCase {
  final SingUpRepository _singUpRepository;
  final SaveUserDataUseCase _saveUserDataUseCase;

  DefaultSingUpUseCase(
      {SingUpRepository? singUpRepository,
      SaveUserDataUseCase? saveUserDataUseCase})
      : _singUpRepository = singUpRepository ?? DefaultSingUpRepository(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase();
  @override
  Future<Result<SingUpEntity, Failure>> execute(
      {required SingUpUseCaseParameters params}) {
    return _singUpRepository
        .singUp(
            params: SingUpRepositoriParameters(
                email: params.email, password: params.password))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          SingUpEntity entity = SingUpEntity.fromJson(result.value!.toJson());
          //Guardar usuario
          return saveUserDataInDataBase(params: params, entity: entity);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}

extension on DefaultSingUpUseCase {
  Future<Result<SingUpEntity, Failure>> saveUserDataInDataBase(
      {required SingUpUseCaseParameters params, required SingUpEntity entity}) {
    SaveUserDataUseCaseParameters _params = SaveUserDataUseCaseParameters(
        localId: entity.localId,
        role: UserRole.user,
        username: params.username,
        email: params.email,
        phone: params.phone,
        dateOfBirth: params.date,
        startDate: DateHelpers.getStarDate(),
        photo: UserPhotoHelper.defaultUserPhoto,
        shippingAddress: "",
        billingAddress: "",
        idToken: entity.idToken,
        provider: UserAuthProvider.emailAndPassword
        );

    return _saveUserDataUseCase.execute(parameters: _params).then((result) {
      switch (result.status) {
        case ResultStatus.success:
          return Result.succes(entity);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
