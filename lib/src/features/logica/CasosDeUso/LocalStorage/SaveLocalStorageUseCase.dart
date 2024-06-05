import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/features/data/Repositories/LocalStorage/SaveLocalStorageRepository.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/FetchLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';

abstract class SaveLocalStorageUseCase {
  Future<void> execute({ required SaveLocalStorageParameters saveLocalParameteres });
  Future<void> saveRecentSearchInLocalStorage({ required String placeId });
  Future<void> clearRecentSearchInLocalStorage();
}

class DefaultSaveLocalStorageUseCase extends SaveLocalStorageUseCase {
  
  // * Dependencies
  final SaveLocalStorageRepository _saveLocalStorageRepository;
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;

  DefaultSaveLocalStorageUseCase({ SaveLocalStorageRepository? saveLocalStorageRepository,
                                   FetchLocalStorageUseCase? fetchLocalStorageUseCase })
      : _saveLocalStorageRepository = saveLocalStorageRepository ?? DefaultSaveLocalStorageRepository(),
        _fetchLocalStorageUseCase = fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase();

  @override
  Future<void> execute({ required SaveLocalStorageParameters saveLocalParameteres }) async {
    _saveLocalStorageRepository.saveInLocalStorage(key: saveLocalParameteres.key,
                                                   value: saveLocalParameteres.value);
  }

  @override
  Future<void> saveRecentSearchInLocalStorage({ required String placeId }) async {
    final placeIds = await _fetchLocalStorageUseCase.fetchRecentSearches();
    if (!placeIds.contains(placeId)) {
      placeIds.add(placeId);
      return _saveLocalStorageRepository.saveRecentSearchInLocalStorage(key: LocalStorageKeys.recentSearches, value: placeIds);
    }
  }

  @override
  Future<void> clearRecentSearchInLocalStorage() {
    return _saveLocalStorageRepository.saveRecentSearchInLocalStorage(key: LocalStorageKeys.recentSearches, value: []);
  }
}
