import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingInUseCase/SingInUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingInUseCase/SingInUseCaseBodyParameters.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/SaveLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/loginPage/Model/login_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';

import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter/material.dart';

// * Métodos y propiedades a exponer en la View
abstract class LoginViewModelInput {
  // Exposed properties
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginModel? loginModel = LoginModel(email: '', password: '');
  // Exposed Methods
  Future<Result<bool, Failure>> login(
      {required String email, required String password});
  bool isFormValidate();
}

// * LoginViewModel
abstract class LoginViewModel extends LoginViewModelInput
    with TextFormFieldDelegate, BaseViewModel {}

class DefaultLoginViewModel extends LoginViewModel {
  // * Dependencies
  // * UseCases
  final SingInUseCase _signInUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  // * Constructor
  DefaultLoginViewModel(
      {SingInUseCase? signInUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _signInUseCase = signInUseCase ?? DefaultSignInUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  // * Init State
  @override
  void initState({required LoadingStateProvider loadingState}) {
    loadingStatusState = loadingState;
  }

  // User Actions
  @override
  Future<Result<bool, Failure>> login(
      {required String email, required String password}) {
    loadingStatusState.setLoadingState(isLoading: true);

    return _signInUseCase
        .execute(
            params: SignInUseCaseParameters(email: email, password: password))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          _saveLocalStorageUseCase.execute(
              saveLocalParameteres: SaveLocalStorageParameters(
                  key: LocalStorageKeys.idToken,
                  value: result.value?.localId ?? ""));
          loadingStatusState.setLoadingState(isLoading: false);
          return Result.succes(true);
        case ResultStatus.error:
          loadingStatusState.setLoadingState(isLoading: false);
          return Result.failure(result.error);
      }
    });
  }

  // Utils
  @override
  bool isFormValidate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {
    switch (customTextFormFieldType) {
      case CustomTextFormFieldType.email:
        loginModel?.email = newValue;
        break;
      case CustomTextFormFieldType.password:
        loginModel?.password = newValue;
        break;
      case CustomTextFormFieldType.username:
        // TODO: Handle this case.
        break;
      case CustomTextFormFieldType.phone:
        // TODO: Handle this case.
        break;
      case CustomTextFormFieldType.dateOfBirth:
        // TODO: Handle this case.
        break;
      case CustomTextFormFieldType.nameInTheCard:
        // TODO: Handle this case.
        break;
      case CustomTextFormFieldType.cardNumber:
        // TODO: Handle this case.
        break;
      case CustomTextFormFieldType.monthAndYearInCard:
        // TODO: Handle this case.
        break;
      case CustomTextFormFieldType.cvc:
        // TODO: Handle this case.
        break;
      case CustomTextFormFieldType.country:
        // TODO: Handle this case.
        break;
    }
  }
}
