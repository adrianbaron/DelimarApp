import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/UpdateEmailUseCase/update_email_use_case.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';

abstract class EditEmailPageViewModelInput {
  Future<UserEntity?> updateEmail(
      {required String oldEmail,
      required String email,
      required String password,
      required String localId});
}

abstract class EditEmailPageViewModel extends EditEmailPageViewModelInput {}

class DefaultEditEmailPageViewModel extends EditEmailPageViewModel {
  // * Dependencies
  final UpdateEmailUseCase _updateEmailUseCase;

  DefaultEditEmailPageViewModel({UpdateEmailUseCase? updateEmailUseCase})
      : _updateEmailUseCase = updateEmailUseCase ?? DefaultUpdateEmailUseCase();

  @override
  Future<UserEntity?> updateEmail(
      {required String oldEmail,
      required String email,
      required String password,
      required String localId}) {
    return _updateEmailUseCase.execute(
        newEmail: email,
        password: password,
        localId: localId,
        oldEmail: oldEmail);
  }
}
