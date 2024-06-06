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

import '../../logica/CasosDeUso/DeliveryAddress/delivery_address_use_case.dart';
import '../../logica/Entidades/DeliveryAddress/delivery_address_entity.dart';

mixin FavouritePageChangeStateDelegate {
  placeFromFavouritesRemoved();
}

class DefaultUserStateProvider extends ChangeNotifier
    with FavouritesCardViewDelegate {
  // Exposed Properties
  UserEntity? userData;

  // Dependencies
  final FetchUserDataUseCase _fetchUserDataUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final FavouritesPlacesUseCase _favouritesPlacesUseCase;
  final PaymentMethodsUseCase _paymentMethodsUseCase;
  final DeliveryAddressUseCase _deliveryAddressUseCase;

  // Delegates
  FavouritePageChangeStateDelegate? favouritePageChangeStateDelegate;

  DefaultUserStateProvider(
      {FetchUserDataUseCase? fetchUserDataUseCase,
      FavouritesPlacesUseCase? favouritesPlacesUseCase,
      SaveUserDataUseCase? saveUserDataUseCase,
      PaymentMethodsUseCase? paymentMethodsUseCase,
      DeliveryAddressUseCase? deliveryAddressUseCase})
      : _fetchUserDataUseCase =
            fetchUserDataUseCase ?? DefaultFetchUserDataUseCase(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase(),
        _favouritesPlacesUseCase =
            favouritesPlacesUseCase ?? DefaultFavouritesPlacesUseCase(),
        _paymentMethodsUseCase =
            paymentMethodsUseCase ?? DefaultPaymentMethodsUseCase(),
        _deliveryAddressUseCase =
            deliveryAddressUseCase ?? DefaultDeliveryAddressUseCase();

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

// UserData
extension UserData on DefaultUserStateProvider {
  fetchUserData({required String localId}) async {
    userData = await _fetchUserDataUseCase.execute(localId: localId);
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
          return Future.error(AppFailureMessages.unExpectedErrorMessage);
      }
    });
  }
}

// Favourites
extension Favourites on DefaultUserStateProvider {
  Future<List<PlaceListDetailEntity>> fetchUserFavouritePlaces() async {
    var placeList = await _favouritesPlacesUseCase.fetchFavouritesPlaces(
        localId: userData?.localId ?? "");
    return placeList.placeList ?? [];
  }
}

// PaymentMethods
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

// DeliveryAddress
extension DeliveryAddress on DefaultUserStateProvider {
  Future<DeliveryAddressListEntity?> getDeliveryAddressList() {
    return _deliveryAddressUseCase.getDeliveryAddressList(
        localId: userData?.localId ?? "");
  }

  Future<DeliveryAddressListEntity?> addDeliveryAddress(
      {required DeliveryAddressEntity deliveryAddressEntity}) async {
    var deliveryAddressList = await getDeliveryAddressList();
    deliveryAddressList?.deliveryAddressList.add(deliveryAddressEntity);

    if (deliveryAddressList == null) {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    }
    return _saveDeliveryAddress(parameters: deliveryAddressList);
  }

  Future<DeliveryAddressListEntity?> editDeliveryAddress(
      {required DeliveryAddressEntity deliveryAddressEntity}) async {
    var deliveryAddressList = await getDeliveryAddressList();
    int? idx = deliveryAddressList?.deliveryAddressList
        .indexWhere((item) => item.id == deliveryAddressEntity.id);

    if (idx != -1 && idx != null && deliveryAddressList != null) {
      deliveryAddressList.deliveryAddressList[idx] = deliveryAddressEntity;
      return _saveDeliveryAddress(parameters: deliveryAddressList);
    } else {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    }
  }

  Future<DeliveryAddressListEntity?> deleteDeliveryAddress(
      {required DeliveryAddressEntity deliveryAddressEntity}) async {
    var deliveryAddressList = await getDeliveryAddressList();
    int? idx = deliveryAddressList?.deliveryAddressList
        .indexWhere((item) => item.id == deliveryAddressEntity.id);
    if (idx != -1 && idx != null && deliveryAddressList != null) {
      deliveryAddressList.deliveryAddressList.removeAt(idx);
      return _saveDeliveryAddress(parameters: deliveryAddressList);
    } else {
      return Future.error(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    }
  }

  Future<DeliveryAddressListEntity?> _saveDeliveryAddress(
      {required DeliveryAddressListEntity parameters}) {
    return _deliveryAddressUseCase.saveDeliveryAddressList(
        localId: userData?.localId ?? "", parameters: parameters);
  }
}

// BuildContext
extension DefaultUserStateProviderExtension on BuildContext {
  // Provider
  DefaultUserStateProvider getDefaultUserStateProvider() =>
      Provider.of<DefaultUserStateProvider>(this);
  // UserData
  UserEntity? getUserData() =>
      Provider.of<DefaultUserStateProvider>(this, listen: false).userData;
  Future<UserEntity> updateUserData({required UserEntity user}) =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .updateUserData(user: user);
  // Favourites
  Future<List<PlaceListDetailEntity>> fetchUserFavouritePlaces() =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .fetchUserFavouritePlaces();
  // PaymentMethods
  Future<PaymentMethodsEntity?> getPaymentMethods() =>
      Provider.of<DefaultUserStateProvider>(this).getPaymentMethods();
  Future<PaymentMethodsEntity?> addPaymentMethod(
          {required PaymentMethodEntity paymentMethod}) =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .addPaymentMethod(paymentMethod: paymentMethod);
  Future<PaymentMethodsEntity?> editPaymentMethod(
          {required PaymentMethodEntity paymentMethod}) =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .editPaymentMethod(paymentMethod: paymentMethod);
  Future<PaymentMethodsEntity?> deletePaymentMethod(
          {required PaymentMethodEntity paymentMethod}) =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .deletePaymentMethod(paymentMethod: paymentMethod);

  // Delivery Address
  Future<DeliveryAddressListEntity?> getDeliveryAddressList() =>
      Provider.of<DefaultUserStateProvider>(this).getDeliveryAddressList();
  Future<DeliveryAddressListEntity?> addDeliveryAddress(
          {required DeliveryAddressEntity deliveryAddressEntity}) =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .addDeliveryAddress(deliveryAddressEntity: deliveryAddressEntity);
  Future<DeliveryAddressListEntity?> editDeliveryAddress(
          {required DeliveryAddressEntity deliveryAddressEntity}) =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .editDeliveryAddress(deliveryAddressEntity: deliveryAddressEntity);
  Future<DeliveryAddressListEntity?> deleteDeliveryAddress(
          {required DeliveryAddressEntity deliveryAddressEntity}) =>
      Provider.of<DefaultUserStateProvider>(this, listen: false)
          .deleteDeliveryAddress(deliveryAddressEntity: deliveryAddressEntity);
}
