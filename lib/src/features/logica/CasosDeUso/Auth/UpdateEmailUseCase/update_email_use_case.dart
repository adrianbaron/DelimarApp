import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/UpdateEmail/update_email_repository.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/FetchUserDataUseCase/FetchUserDateUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCase.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class UpdateEmailUseCase {
  Future<UserEntity?> execute(
      {required String oldEmail,
      required String newEmail,
      required String password,
      required String localId});
}

class DefaultUpdateEmailUseCase extends UpdateEmailUseCase {
  // * Dependencies
  final UpdateEmailRepository _updateEmailRepository;
  final FetchUserDataUseCase _fetchUserDataUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  DefaultUpdateEmailUseCase(
      {UpdateEmailRepository? updateEmailRepository,
      FetchUserDataUseCase? fetchUserDataUseCase,
      SaveUserDataUseCase? saveUserDataUseCase})
      : _updateEmailRepository =
            updateEmailRepository ?? DefaultUpdateEmailRepository(),
        _fetchUserDataUseCase =
            fetchUserDataUseCase ?? DefaultFetchUserDataUseCase(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase();

  @override
  Future<UserEntity?> execute(
      {required String oldEmail,
      required String newEmail,
      required String password,
      required String localId}) async {
    try {
      final _ = await _updateEmailRepository.updateEmail(
          oldEmail: oldEmail, newEmail: newEmail, password: password);
      return await _updateEmailInDataBase(newEmail: newEmail, localId: localId);
    } on Failure catch (f) {
      return Future.error(Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }

  Future<UserEntity?> _updateEmailInDataBase(
      {required String newEmail, required String localId}) async {
    try {
      var userData = await _fetchUserDataUseCase.execute(localId: localId);
      userData.email = newEmail;
      _saveUserDataUseCase
          .execute(parameters: userData.getSaveUserDataParams())
          .then((result) {
        switch (result.status) {
          case ResultStatus.success:
            return result.value;
          case ResultStatus.error:
            return Future.error(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
        }
      });
    } on Failure catch (f) {
      return Future.error(Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
