import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/UpdatePasswordUseCase/UpdatePasswordUseCase.dart';

abstract class ForgotPasswordViewModelInput {
  late String email;
  Future<void> updatePassword();
}

abstract class ForgotPasswordViewModel extends ForgotPasswordViewModelInput {}

class DefaultForgotPasswordViewModel extends ForgotPasswordViewModel {
  //DEPENDENCIA
  final UpdatePasswordUseCase _updatePasswordUseCase;

  DefaultForgotPasswordViewModel({UpdatePasswordUseCase? updatePasswordUseCase})
      : _updatePasswordUseCase =
            updatePasswordUseCase ?? DefaultUpdatePasswordUseCase();
  @override
  Future<void> updatePassword() {
    return _updatePasswordUseCase.execute(email: email);
  }
}
