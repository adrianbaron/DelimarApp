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

abstract class LoginViewModelInput {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  LoginModel? loginModel = LoginModel(email: "", password: "");
  Future<Result<bool, Failure>> login(
      {required String email, required String password});
  bool isFormValidate();
}

abstract class LoginViewModel extends LoginViewModelInput
    with TextFormFieldDelegate, BaseViewModel {}

class DefaultLoginViewModel extends LoginViewModel {
  //DEPENDENCIAS
  //USE CASES
  final SingInUseCase _singInUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  DefaultLoginViewModel(
      {SingInUseCase? singInUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _singInUseCase = singInUseCase ?? DefaultSingInUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();
  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
  }

  @override
  bool isFormValidate() {
    return formkey.currentState?.validate() ?? false;
  }

  @override
  Future<Result<bool, Failure>> login(
      {required String email, required String password}) {
    loadingState.setLoadingState(isLoading: true);
    return _singInUseCase
        .execute(
            params:
                SingInUseCaseBodyParameters(email: email, password: password))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          loadingState.setLoadingState(isLoading: false);
          _saveLocalStorageUseCase.execute(
              parameters: SaveLocalStorageParameters(
                  key: LocalStorageKeys.idToken,
                  value: result.value?.idToken ?? ""));
          return Result.succes(true);
        case ResultStatus.error:
          loadingState.setLoadingState(isLoading: false);
          return Result.failure(result.error);
      }
    });
  }

  @override
  onChange(
      {required String newValue,
      required CustonTextFormFieldType custonTextFormFieldType}) {
    switch (custonTextFormFieldType) {
      case CustonTextFormFieldType.email:
        loginModel?.email = newValue;
      case CustonTextFormFieldType.password:
        loginModel?.password = newValue;
      case CustonTextFormFieldType.phone:
      // TO
      case CustonTextFormFieldType.username:
      // TO
      case CustonTextFormFieldType.dataOfBirth:
      // TO
    }
  }
}
