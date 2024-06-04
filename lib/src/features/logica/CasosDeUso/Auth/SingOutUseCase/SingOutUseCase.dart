import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/RemoveLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';

abstract class SingOutUseCase {
  Future<void> execute();
}

class DefaultSingOutUseCase extends SingOutUseCase {
  //DEPENDENCIA
  final RemoveLocalStorageUseCase _removeLocalStorageUseCase;

  DefaultSingOutUseCase({RemoveLocalStorageUseCase? removeLocalStorageUseCase})
      : _removeLocalStorageUseCase =
            removeLocalStorageUseCase ?? DefaultRemoveLocalStorageUseCase();
  @override
  Future<void> execute() {
    return _removeLocalStorageUseCase.execute(
        parameters:
            RemoveLocalStorageParameters(key: LocalStorageKeys.idToken));
  }
}
