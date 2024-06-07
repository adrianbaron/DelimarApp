import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/FetchLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/SaveLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/ValidatedCurrentUserUseCase/ValidatedCurrentUserUseCase.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';

import 'package:app_delivery/src/features/presentacion/Categorias/Collection_detail_page/ViewModel/collections_detail_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/Categorias/Collection_detail_page/collection_detail_page.dart';
import 'package:app_delivery/src/features/presentacion/Categorias/collectionPage/View/collection_page.dart';
import 'package:app_delivery/src/features/presentacion/Filters/FiltersPage/View/filter_page.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/PlaceRatingPage/place_rating_page.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/PopularPlacesListView/popular_places_list_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/order_confirmation_page.dart';

import 'package:app_delivery/src/features/presentacion/Profile/AddEditCardPage/add_edit_card_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/AddEditDeliveryAddressPage/add_edit_delivery_address_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/AddEditPaypalAccountPage/add_edit_paypal_account_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangeDeliveryAddressPage/change_delivery_address_page.dart';

import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/place_detail_page.dart';
import 'package:app_delivery/src/features/presentacion/welcomePage/View/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../logica/Entidades/DeliveryAddress/delivery_address_entity.dart';

class RoutesPaths {
  static String loginPath = "login";
  static String welcomePath = 'welcome';
  static String tabsPath = 'tabs';
  static String signUpPath = 'singUp';
  static String changePaymentMethodsPath = "change-payments-methods";
  static String editPasswordPath = "edit-password";
  static String editEmailPath = "edit-email";
  static String updatePasswordPath = "forgot-pass";
}

class MainCoordinator {
  // Dependencies
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;
  final ValidateCurrentUserUseCase _validateCurrentUserCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  // Exposed Properties
  String? userUid;
  static MainCoordinator? sharedInstance = MainCoordinator();

  MainCoordinator(
      {FetchLocalStorageUseCase? fetchLocalStorageUseCase,
      ValidateCurrentUserUseCase? validateCurrentUserCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
        _validateCurrentUserCase =
            validateCurrentUserCase ?? DefaultValidateCurrentUserUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  Future<String?> start(BuildContext context) {
    return _isUserLogged(context).then((value) {
      return value == null ? RoutesPaths.welcomePath : RoutesPaths.tabsPath;
    });
  }
}

extension AuthNavigation on MainCoordinator {
  showWelcomePage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.welcomePath);
  }

  showLoginPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.loginPath);
  }

  logoutNavigation({required BuildContext context}) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => WelcomePage(),
            transitionDuration: const Duration(seconds: 0)));
  }

  showSignUpPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.signUpPath);
  }

  showTabsPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.tabsPath);
  }

  showUpdatePasswordPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.updatePasswordPath);
  }
}

extension PlacesNavigation on MainCoordinator {
  showPlaceListPage(
      {required BuildContext context,
      required List<PlaceDetailEntity> popularPlaces}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                PopularPlacesListPage(popularPlaces: popularPlaces),
            transitionDuration: const Duration(seconds: 0)));
  }

  showPlaceDetailPage(
      {required BuildContext context, required PlaceDetailEntity place}) async {
    await _saveLocalStorageUseCase.saveRecentSearchInLocalStorage(
        placeId: place.placeId);
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => PlaceDetailPage(
                viewModel: DefaultPlaceDetailViewModel(place: place)),
            transitionDuration: const Duration(seconds: 0)));
  }

  showCollectionsPage(
      {required BuildContext context,
      required List<CollectionDetailEntity> collections}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                CollectionsPage(collections: collections),
            transitionDuration: const Duration(seconds: 0)));
  }

  showCollectionsDetailPage(
      {required BuildContext context,
      required CollectionDetailEntity collection}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => CollectionDetailPage(
                collectionDetailPageViewModel:
                    DefaultCollectionDetailPageViewModel(
                        collection: collection)),
            transitionDuration: const Duration(seconds: 0)));
  }

  showFiltersPage(
      {required BuildContext context, required FilterPageDelegate delegate}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => FilterPage(delegate: delegate),
            transitionDuration: const Duration(seconds: 0)));
  }

  showRatingsPage(
      {required BuildContext context,
      required List<PlaceRatingEntity> placeRatings}) {
    _pushPage(
        context: context, page: PlaceRatingsPage(placeRatings: placeRatings));
  }
}

extension PaymentMethodsNavigation on MainCoordinator {
  showEditPasswordPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.editPasswordPath);
  }

  showEditEmailPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.editEmailPath);
  }

  showChangePaymentsMethodsPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPaths.changePaymentMethodsPath);
  }

  showAddEditCardPage(
      {required BuildContext context,
      bool? isForEditing,
      bool? isForCreateAVisaCard,
      PaymentMethodEntity? paymentMethod,
      BaseViewStateDelegate? viewStateDelegate}) {
    _pushPage(
        context: context,
        page: AddEditCardPage(
            isEditing: isForEditing,
            isForCreateAVisaCard: isForCreateAVisaCard,
            paymentMethod: paymentMethod,
            viewStateDelegate: viewStateDelegate));
  }

  showAddEditPaypalAccountPage(
      {required BuildContext context,
      bool? isForEditing,
      PaymentMethodEntity? paymentMethod,
      BaseViewStateDelegate? viewStateDelegate}) {
    _pushPage(
        context: context,
        page: AddEditPaypalAccountPage(
            isEditing: isForEditing,
            paymentMethod: paymentMethod,
            viewStateDelegate: viewStateDelegate));
  }
}

extension DeliveryAddressNavigation on MainCoordinator {
  showChangeDeliveryAddress({required BuildContext context}) {
    _pushPage(context: context, page: const ChangeDeliveryAddressPage());
  }

  showAddEditDeliveryAddress(
      {required BuildContext context,
      required bool? isForEditing,
      DeliveryAddressEntity? deliveryAddressEntity,
      required BaseViewStateDelegate? viewStateDelegate}) {
    _pushPage(
        context: context,
        page: AddEditDeliveryAddressPage(
            deliveryAddressEntity: deliveryAddressEntity,
            viewStateDelegate: viewStateDelegate,
            isEditing: isForEditing));
  }
}

extension OrdersNavigation on MainCoordinator {
    showOrderConfimationPage({ required BuildContext context, required OrderEntity order }) {
        _pushPage(
            context: context,
            page: OrderConfirmationPage(order: order));
    }
}

extension PrivateMethods on MainCoordinator {
  Future<String?> _isUserLogged(BuildContext context) async {
    var idToken = await _fetchLocalStorageUseCase.execute(
        fetchLocalParameteres:
            FetchLocalStorageParameters(key: LocalStorageKeys.idToken));
    userUid = idToken;
    return idToken;
  }

  _pushPage({required BuildContext context, required Widget page}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => page,
            transitionDuration: const Duration(seconds: 0)));
  }
}
