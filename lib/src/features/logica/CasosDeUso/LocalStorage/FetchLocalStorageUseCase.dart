import 'package:app_delivery/src/features/data/Repositories/LocalStorage/FetchLocalStorageRepository%20.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';

abstract class FetchLocalStorageUseCase {
  Future<String?> execute({required FetchLocalStorageParameters parameters});
  Future<List<String>> fetchRecentSearches();
}

class DefaultFetchLocalStorageUseCase extends FetchLocalStorageUseCase {
  //dependencia
  final FetchLocalStorageRepository _fetchLocalStorageRepository;

  DefaultFetchLocalStorageUseCase(
      {FetchLocalStorageRepository? fetchLocalStorageRepository})
      : _fetchLocalStorageRepository =
            fetchLocalStorageRepository ?? DefaultFetchLocalStorageRepository();
  @override
  Future<String?> execute(
      {required FetchLocalStorageParameters parameters}) async {
    return await _fetchLocalStorageRepository.fetchInLocalStorage(
        key: parameters.key);
  }

  @override
  Future<List<String>> fetchRecentSearches() async {
    final recentSearches =
        await _fetchLocalStorageRepository.fetchRecentSearches();
    return recentSearches ?? [];
  }
}
