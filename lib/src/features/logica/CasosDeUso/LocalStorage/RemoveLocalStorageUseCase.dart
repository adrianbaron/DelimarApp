import 'package:app_delivery/src/features/data/Repositories/LocalStorage/RemoveLocalStorageRepository.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';

abstract class RemoveLocalStorageUseCase {
  Future<void> execute({required RemoveLocalStorageParameters parameters});
}

class DefaultRemoveLocalStorageUseCase extends RemoveLocalStorageUseCase {
  //DEPENDENCIA
  final RemoveLocalStorageRepository _removeLocalStorageRepository;

  DefaultRemoveLocalStorageUseCase(
      {RemoveLocalStorageRepository? removeLocalStorageRepository})
      : _removeLocalStorageRepository = removeLocalStorageRepository ??
            DefaultRemoveLocalStorageRepository();

  @override
  Future<void> execute(
      {required RemoveLocalStorageParameters parameters}) async {
    return await _removeLocalStorageRepository.removeInLocalStorage(
        key: parameters.key);
  }
}
