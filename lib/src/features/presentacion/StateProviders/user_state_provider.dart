import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Places/FavoritePlacesUseCase/favorite_places_use_case.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/FetchUserDataUseCase/FetchUserDateUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Cards/favoriteCard.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin FavouritePageChangeStateDelegate {
  placeFromFavouritesRemoved();
}

class DefaultUserStateProvider extends ChangeNotifier
    with FavouritesCardViewDelegate {
  UserEntity? userData;

  // Dependencies
  final FetchUserDataUseCase _fetchUserDataUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final FavouritesPlacesUseCase _favouritesPlacesUseCase;

  // Delegates
  FavouritePageChangeStateDelegate? favouritePageChangeStateDelegate;

  DefaultUserStateProvider(
      {FetchUserDataUseCase? fetchUserDataUseCase,
      FavouritesPlacesUseCase? favouritesPlacesUseCase,
      SaveUserDataUseCase? saveUserDataUseCase})
      : _fetchUserDataUseCase =
            fetchUserDataUseCase ?? DefaultFetchUserDataUseCase(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase(),
        _favouritesPlacesUseCase =
            favouritesPlacesUseCase ?? DefaultFavouritesPlacesUseCase();

  fetchUserData({required String localId}) async {
    userData = await _fetchUserDataUseCase.execute(localId: localId);
    // Aquí puedes imprimir el campo username
    print('Username desde la base de datos: ${userData?.username}');
  }

  Future<UserEntity> updateUserData({required UserEntity user}) async {
    return _saveUserDataUseCase
        .execute(parameters: SaveUserDataUseCaseParameters.fromUserEntity(user))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Future.error(AppFailureMessages.unExpectedErrorMessage);
          }
          return result.value!;
        case ResultStatus.error:
          if (userData != null) {
            print('Username desde la base de datos: ${userData?.username}');
          } else {
            print('No se encontraron datos de usuario');
          }
          return Future.error(AppFailureMessages.unExpectedErrorMessage);
      }
    });
  }

  Future<List<PlaceListDetailEntity>> fetchUserFavouritePlaces() async {
    var placeList = await _favouritesPlacesUseCase.fetchFavouritesPlaces(
        localId: userData?.localId ?? "");
    return placeList.placeList ?? [];
  }

  @override
  favouriteIconTapped(bool isTapped, String placeId) async {
    await _favouritesPlacesUseCase.saveOrRemoveUserFromPlaceFavourites(
        placeId: placeId,
        localId: MainCoordinator.sharedInstance?.userUid ?? "",
        isFavourite: isTapped);
    if (!isTapped) {
      favouritePageChangeStateDelegate?.placeFromFavouritesRemoved();
    }
  }
}

extension DefaultUserStateProviderExtension on BuildContext {
  DefaultUserStateProvider getDefaultUserStateProvider() =>
      Provider.of<DefaultUserStateProvider>(this);
  UserEntity? getUserData() =>
      Provider.of<DefaultUserStateProvider>(this).userData;
  Future<UserEntity> updateUserData({required UserEntity user}) =>
      Provider.of<DefaultUserStateProvider>(this).updateUserData(user: user);
}
