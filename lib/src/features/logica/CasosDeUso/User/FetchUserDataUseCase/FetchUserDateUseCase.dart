import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Repositories/User/SaveUserDataRepository/FetchUserDataRepository.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class FetchUserDataUseCase {
  Future<UserEntity> execute({required String localId});
}

class DefaultFetchUserDataUseCase extends FetchUserDataUseCase {
  // Dependencies
  final FetchUserDataRepository _fetchUserDataRepository;

  DefaultFetchUserDataUseCase(
      {FetchUserDataRepository? fetchUserDataRepository})
      : _fetchUserDataRepository =
            fetchUserDataRepository ?? DefaultFetchUserDataRepository();

  @override
  Future<UserEntity> execute({required String localId}) {
    return _fetchUserDataRepository
        .fetchUserData(localId: localId)
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Future.error(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }

          return UserEntity.fromMap(result.value!.toMap());
        case ResultStatus.error:
          return Future.error(Failure.fromMessage(
              message: AppFailureMessages.unExpectedErrorMessage));
      }
    });
  }
}
