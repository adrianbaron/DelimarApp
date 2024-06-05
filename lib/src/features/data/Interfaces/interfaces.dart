//Auth Repositry

import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Managers/PlacesdManager/decorables/place_list_decorable.dart';
import 'package:app_delivery/src/features/data/Decorables/Auth/UserAuthData/UserAuthDataDecorable.dart';
import 'package:app_delivery/src/features/data/Decorables/Collections/CollectionsDecorable.dart';
import 'package:app_delivery/src/features/data/Decorables/User/UserDecorable.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingInRepository/SingInBodyParameters.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/SingUpRepository/singUpRepositoriParams.dart';
import 'package:app_delivery/src/features/data/Repositories/Auth/UserAuthDataRepository/UserAuthDataRepositoryBodyParameters.dart';
import 'package:app_delivery/src/features/data/Repositories/User/SaveUserDataRepository/UserBodyParans.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/SingInDecorable.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/SingUpDecorable.dart';
import 'package:app_delivery/src/services/FirebaseService/AuthFirebase/Decorable/UpdatePasswordDecorable.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

//Auth Repositories

abstract class SingInRepository {
  Future<Result<SingInDecorable, Failure>> singIn(
      {required SingInBodyParameters params});
}

abstract class SingUpRepository {
  Future<Result<SingUpDecorable, Failure>> singUp(
      {required SingUpRepositoriParameters params});
}

abstract class UpdatePasswordRepository {
  Future<Result<UpdatePasswordDecorable, Failure>> updatePassword(
      {required String email});
}

abstract class UpdateEmailRepository {
  Future<dynamic> updateEmail(
      {required String oldEmail,
      required String newEmail,
      required String password});
}

abstract class UserAuthDataRepository {
  Future<Result<UserAuthDataDecorable, Failure>> getUserAuthData(
      {required GetUserDataBodyParameters parameters});
}

//User Data base repository
abstract class SaveUserDataRepository {
  Future<Result<UserDecodable, Failure>> saveUserData(
      {required UserBodyParameters params});
}

abstract class FetchUserDataRepository {
  Future<Result<UserDecodable, Failure>> fetchUserData(
      {required String localId});
}

//MANEJO DE LOCAL STORAGE

abstract class SaveLocalStorageRepository {
  Future<void> saveInLocalStorage({required String key, required String value});
  Future<void> saveRecentSearchInLocalStorage(
      {required String key, required List<String> value});
}

abstract class FetchLocalStorageRepository {
  Future<String?> fetchInLocalStorage({required String key});
  Future<List<String>?> fetchRecentSearches();
}

abstract class RemoveLocalStorageRepository {
  Future<void> removeInLocalStorage({required String key});
}

// * Collections Repositories
abstract class CollectionsRepository {
  Future<CollectionsDecodable> fetchCollections();
}

// * Places Repositories
abstract class PlaceListRepository {
  Future<PlaceListDecorable> fetchPlaceList();
  Future<PlaceListDecorable> fetchNoveltyPlaceList();
  Future<PlaceListDecorable> fetchPopularPlacesList();
  Future<PlaceListDecorable> fetchPlacesListByCategory(
      {required int categoryId});
  Future<PlaceListDecorable> fetchPlacesListByQuery({required String query});
  Future<PlaceListDecorable> fetchPlacesListByRecentSearches(
      {required List<String> placeIds});
}

// * Places Repositories
abstract class PlaceDetailRepository {
  Future<void> savePlaceDetail({required PlaceListDetailEntity placeDetail});
}
