import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingUpUseCase/SingUpCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingUpUseCase/SingUpUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/SaveLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/presentacion/SingUpPage/Model/SingUpModel.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter/material.dart';

abstract class SingUpViewModelInpunt {
  late TextEditingController dateControler;
  late DateTime selectedDate;
  SingUpModel? singUpModel = SingUpModel();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<Result<bool, Failure>> singUp();
  isFormValidate();
}

abstract class SingUpViewModel extends SingUpViewModelInpunt
    with TextFormFieldDelegate, BaseViewModel {}

class DefaultSingUpViewModel extends SingUpViewModel {
  //DEPENDENCIAS
  final SingUpUseCase _singUpUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  DefaultSingUpViewModel(
      {SingUpUseCase? singUpUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _singUpUseCase = singUpUseCase ?? DefaultSingUpUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();
  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
    dateControler = TextEditingController();
    selectedDate = DateTime.now();
  }

  @override
  isFormValidate() {
    return formkey.currentState?.validate() ?? false;
  }

  @override
  Future<Result<bool, Failure>> singUp() {
    loadingState.setLoadingState(isLoading: true);
    return _singUpUseCase
        .execute(
            params: SingUpUseCaseParameters(
                username: singUpModel?.username ?? "",
                email: singUpModel?.email ?? "",
                password: singUpModel?.password ?? "",
                phone: singUpModel?.phone ?? "",
                date: singUpModel?.date ?? ""))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          _saveLocalStorageUseCase.execute(
              parameters: SaveLocalStorageParameters(
                  key: LocalStorageKeys.idToken,
                  value: result.value?.idToken ?? ""));

          loadingState.setLoadingState(isLoading: false);
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
        singUpModel?.email = newValue;
      case CustonTextFormFieldType.password:
        singUpModel?.password = newValue;
      case CustonTextFormFieldType.phone:
        singUpModel?.phone = newValue;
      case CustonTextFormFieldType.username:
        singUpModel?.username = newValue;
      case CustonTextFormFieldType.dataOfBirth:
        singUpModel?.date = newValue;
    }
  }
}
