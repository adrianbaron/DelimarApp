import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/FetchLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/SaveLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/ValidatedCurrentUserUseCase/ValidatedCurrentUserUseCase.dart';
import 'package:app_delivery/src/features/logica/Entidades/Collections/collections_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/Collection_detail_page/ViewModel/collections_detail_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/Collection_detail_page/collection_detail_page.dart';
import 'package:app_delivery/src/features/presentacion/PopularPlacesListView/popular_places_list_view.dart';
import 'package:app_delivery/src/features/presentacion/Profile/AddEditCardPage/add_edit_card_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/AddEditDeliveryAddressPage/add_edit_delivery_address_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/AddEditPaypalAccountPage/add_edit_paypal_account_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangeDeliveryAddressPage/change_delivery_address_page.dart';
import 'package:app_delivery/src/features/presentacion/collectionPage/View/collection_page.dart';
import 'package:app_delivery/src/features/presentacion/places_detail_page/View/place_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../logica/Entidades/DeliveryAddress/delivery_address_entity.dart';

class RoutesPath {
  static String welcomePath = 'welcome';
  static String tabPath = 'tabs';
  static String signUpPath = 'singUp';
  static String changePaymentMethodsPath = "change-payments-methods";
  static String editPasswordPath = "edit-password";
  static String editEmailPath = "edit-email";
}

class MainCoordinator {
  //dependencias
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;
  final ValidateCurrentUserUseCase _validateCurrentUserUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;
  String userUid = "";
  static MainCoordinator? sharedInstance = MainCoordinator();

  MainCoordinator(
      {FetchLocalStorageUseCase? fetchLocalStorageUseCase,
      ValidateCurrentUserUseCase? validateCurrentUserUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
        _validateCurrentUserUseCase =
            validateCurrentUserUseCase ?? DefaultValidateCurrentUserUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  Future<String?> star() {
    return _isUserLogged().then((value) {
      return value == null ? RoutesPath.welcomePath : RoutesPath.tabPath;
    });
  }

 

  showTabsPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPath.tabPath);
  }

  showPopularPlacesListView(
      {required BuildContext context,
      required List<PlaceListDetailEntity> popularPlaces}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                PopularPlaceListPage(popularPlaces: popularPlaces),
            transitionDuration: const Duration(seconds: 0)));
  }

  showCollectionsPage(
      {required BuildContext context,
      required List<CollectionDetailEntity> collections}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                CollectionPage(collections: collections),
            transitionDuration: const Duration(seconds: 0)));
  }

  showSignUpPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPath.signUpPath);
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

  showPlaceDetailPage(
      {required BuildContext context, required String placeId}) async {
    await _saveLocalStorageUseCase.saveRecentSearchInLocalStorage(
        placeId: placeId);
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => PlaceDetailPage(),
            transitionDuration: const Duration(seconds: 0)));
  }

  

  

    showChangePaymentsMethodsPage({ required BuildContext context }) {
    Navigator.pushNamed(context, RoutesPath.changePaymentMethodsPath);
  }





  
  
   
  
}

extension PaymentMethodsNavigation on MainCoordinator {
  showEditPasswordPage({ required BuildContext context }) {
    Navigator.pushNamed(context, RoutesPath.editPasswordPath);
  }

  showEditEmailPage({ required BuildContext context }) {
    Navigator.pushNamed(context, RoutesPath.editEmailPath);
  }

  showChangePaymentsMethodsPage({ required BuildContext context }) {
    Navigator.pushNamed(context, RoutesPath.changePaymentMethodsPath);
  }

  showAddEditCardPage({ required BuildContext context,
                        bool? isForEditing,
                        bool? isForCreateAVisaCard,
                        PaymentMethodEntity? paymentMethod,
                        BaseViewStateDelegate? viewStateDelegate }) {
    _pushPage(context: context,
        page: AddEditCardPage(isEditing: isForEditing,
            isForCreateAVisaCard: isForCreateAVisaCard,
            paymentMethod: paymentMethod,
            viewStateDelegate: viewStateDelegate));
  }

  showAddEditPaypalAccountPage({ required BuildContext context,
                                 bool? isForEditing,
                                PaymentMethodEntity? paymentMethod,
                                BaseViewStateDelegate? viewStateDelegate }) {
    _pushPage(context: context,
        page: AddEditPaypalAccountPage(isEditing: isForEditing,
                                       paymentMethod: paymentMethod,
                                       viewStateDelegate: viewStateDelegate));
  }
}

extension DeliveryAddressNavigation on MainCoordinator {
  showChangeDeliveryAddress({ required BuildContext context }) {
    _pushPage(context: context, page: const ChangeDeliveryAddressPage());
  }

  showAddEditDeliveryAddress({ required BuildContext context,
                               required bool? isForEditing,
                               DeliveryAddressEntity? deliveryAddressEntity,
                               required BaseViewStateDelegate? viewStateDelegate }) {
    _pushPage(context: context, page: AddEditDeliveryAddressPage(deliveryAddressEntity: deliveryAddressEntity,
                                                                 viewStateDelegate: viewStateDelegate,
                                                                 isEditing: isForEditing));
  }
}


extension PrivateMethods on MainCoordinator {
   Future<String?> _isUserLogged() async {
    var idToken = await _fetchLocalStorageUseCase.execute(
        fetchLocalParameteres:
            FetchLocalStorageParameters(key: LocalStorageKeys.idToken));
    userUid = idToken ?? "";
    return idToken;
  }

  _pushPage({ required BuildContext context,
              required Widget page }) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___) => page,
            transitionDuration: const Duration(seconds: 0)
        ));
  }
}
 