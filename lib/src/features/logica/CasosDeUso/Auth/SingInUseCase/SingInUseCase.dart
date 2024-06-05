import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingInRepository/SingInBodyParameters.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingInRepository/SingInRepository.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingInUseCase/SingInUseCaseBodyParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/Auth/SingInEntity/SingInEntity.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class SingInUseCase {
  Future<Result<SingInEntity, Failure>> execute({ required SignInUseCaseParameters params });
}

class DefaultSignInUseCase extends SingInUseCase {
   
  // * Dependencies
  final SingInRepository _signInRepository;

  DefaultSignInUseCase({ SingInRepository? signInRepository }) : _signInRepository = signInRepository ?? DefaultSingInRepository();

  @override
  Future<Result<SingInEntity, Failure>> execute({ required SignInUseCaseParameters params }) {
    return _signInRepository
        .singIn(params: SingInBodyParameters(email: params.email, password: params.password))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          // Null Check
          if (result.value == null) {
            return Result.failure(
                Failure.fromMessage(message: AppFailureMessages.unExpectedErrorMessage));
          }
          return Result.succes(SingInEntity.fromJson(result.value!.toJson()));
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}