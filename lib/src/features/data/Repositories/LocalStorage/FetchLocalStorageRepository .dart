import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultFetchLocalStorageRepository extends FetchLocalStorageRepository {
  //DEPENDENCIA
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<String?> fetchInLocalStorage({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<List<String>?> fetchRecentSearches() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(LocalStorageKeys.recentSearches);
  }
}

