import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/PaymentMethods/payments_methods_use_case.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Places/FavoritePlacesUseCase/favorite_places_use_case.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/FetchUserDataUseCase/FetchUserDateUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
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
  final PaymentMethodsUseCase _paymentMethodsUseCase;

  // Delegates
  FavouritePageChangeStateDelegate? favouritePageChangeStateDelegate;

  DefaultUserStateProvider(
      {FetchUserDataUseCase? fetchUserDataUseCase,
      FavouritesPlacesUseCase? favouritesPlacesUseCase,
      SaveUserDataUseCase? saveUserDataUseCase,
      PaymentMethodsUseCase? paymentMethodsUseCase})
      : _fetchUserDataUseCase =
            fetchUserDataUseCase ?? DefaultFetchUserDataUseCase(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase(),
        _favouritesPlacesUseCase =
            favouritesPlacesUseCase ?? DefaultFavouritesPlacesUseCase(),
        _paymentMethodsUseCase =
            paymentMethodsUseCase ?? DefaultPaymentMethodsUseCase();

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

//USER DATA
extension UserData on DefaultUserStateProvider {
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
          userData = result.value;
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
}

//FAVORITOS

extension Favorites on DefaultUserStateProvider {
  Future<List<PlaceListDetailEntity>> fetchUserFavouritePlaces() async {
    var placeList = await _favouritesPlacesUseCase.fetchFavouritesPlaces(
        localId: userData?.localId ?? "");
    return placeList.placeList ?? [];
  }
}

//PAYMENTS METHODS
extension PaymentMethods on DefaultUserStateProvider {
  Future<PaymentMethodsEntity?> getPaymentMethods() {
    return _paymentMethodsUseCase.getPaymentMethods(
        localId: userData?.localId ?? "");
  }

  Future<PaymentMethodsEntity?> addPaymentMethod(
      {required PaymentMethodEntity paymentMethod}) async {
    var paymentMethods = await getPaymentMethods();
    paymentMethods?.paymentMethods.add(paymentMethod);

    if (paymentMethods == null) {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    }
    return _savePaymentMethods(parameters: paymentMethods);
  }

  Future<PaymentMethodsEntity?> editPaymentMethod(
      {required PaymentMethodEntity paymentMethod}) async {
    var paymentMethods = await getPaymentMethods();
    int? idx = paymentMethods?.paymentMethods
        .indexWhere((item) => item.id == paymentMethod.id);

    if (idx != -1 && idx != null && paymentMethods != null) {
      paymentMethods.paymentMethods[idx] = paymentMethod;
      return _savePaymentMethods(parameters: paymentMethods);
    } else {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    }
  }

  Future<PaymentMethodsEntity?> deletePaymentMethod(
      {required PaymentMethodEntity paymentMethod}) async {
    var paymentMethods = await getPaymentMethods();
    int? idx = paymentMethods?.paymentMethods
        .indexWhere((item) => item.id == paymentMethod.id);
    if (idx != -1 && idx != null && paymentMethods != null) {
      paymentMethods.paymentMethods.removeAt(idx);
      return _savePaymentMethods(parameters: paymentMethods);
    } else {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    }
  }

  Future<PaymentMethodsEntity?> _savePaymentMethods(
      {required PaymentMethodsEntity parameters}) {
    return _paymentMethodsUseCase.savePaymentMethods(
        localId: userData?.localId ?? "", parameters: parameters);
  }
}

//
extension DefaultUserStateProviderExtension on BuildContext {

  //USERDATA
  DefaultUserStateProvider getDefaultUserStateProvider() =>
      Provider.of<DefaultUserStateProvider>(this);
  UserEntity? getUserData() =>
      Provider.of<DefaultUserStateProvider>(this).userData;
  Future<UserEntity> updateUserData({required UserEntity user}) =>
      Provider.of<DefaultUserStateProvider>(this).updateUserData(user: user);

  //PAYMENTSMETHODS
  Future<PaymentMethodsEntity?> getPaymentMethods() => Provider.of<DefaultUserStateProvider>(this).getPaymentMethods();
  Future<PaymentMethodsEntity?> addPaymentMethod({ required PaymentMethodEntity paymentMethod }) => Provider.of<DefaultUserStateProvider>(this, listen: false).addPaymentMethod(paymentMethod: paymentMethod);
  Future<PaymentMethodsEntity?> editPaymentMethod({ required PaymentMethodEntity paymentMethod }) => Provider.of<DefaultUserStateProvider>(this, listen: false).editPaymentMethod(paymentMethod: paymentMethod);
  Future<PaymentMethodsEntity?> deletePaymentMethod({ required PaymentMethodEntity paymentMethod }) => Provider.of<DefaultUserStateProvider>(this, listen: false).deletePaymentMethod(paymentMethod: paymentMethod);
}
