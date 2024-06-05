import 'package:app_delivery/src/features/data/Repositories/Auth/UpdatePasswordRepository/UpdatePasswordRepository.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';

abstract class UpdatePasswordUseCase {
  Future<void> execute({required String email});
}

class DefaultUpdatePasswordUseCase extends UpdatePasswordUseCase {
  // * Dependencies
  final UpdatePasswordRepository _updatePasswordRepository;

  DefaultUpdatePasswordUseCase(
      {UpdatePasswordRepository? updatePasswordRepository})
      : _updatePasswordRepository =
            updatePasswordRepository ?? DefaultUpdatePasswordRepository();

  @override
  Future<void> execute({required String email}) {
    return _updatePasswordRepository.updatePassword(email: email);
  }
}
