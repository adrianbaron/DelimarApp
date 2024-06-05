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

abstract class SignUpViewModelInput {
  // Exposed Properties
  SingUpModel? signUpModel = SingUpModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController dateController;
  late DateTime selectedDate;
  // Exposed Methods
  Future<Result<bool, Failure>> signUp();
  bool isFormValidate();
}

abstract class SignUpViewModel extends SignUpViewModelInput
    with TextFormFieldDelegate, BaseViewModel {}

class DefaultSignUpViewModel extends SignUpViewModel {
  // UseCases
  final SingUpUseCase _signUpUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  DefaultSignUpViewModel(
      {SingUpUseCase? signUpUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _signUpUseCase = signUpUseCase ?? DefaultSingUpUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  // Init
  @override
  void initState({required LoadingStateProvider loadingState}) {
    loadingStatusState = loadingState;
    dateController = TextEditingController();
    selectedDate = DateTime.now();
  }

  // User Actions
  @override
  Future<Result<bool, Failure>> signUp() async {
    loadingStatusState.setLoadingState(isLoading: true);

    return _signUpUseCase
        .execute(
            params: SingUpUseCaseParameters(
                email: signUpModel?.email ?? "",
                password: signUpModel?.password ?? "",
                username: signUpModel?.username ?? "",
                phone: signUpModel?.phone ?? "",
                date: signUpModel?.date ?? ""))
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
        signUpModel?.email = newValue;
        break;
      case CustomTextFormFieldType.password:
        signUpModel?.password = newValue;
        break;
      case CustomTextFormFieldType.username:
        signUpModel?.username = newValue;
        break;
      case CustomTextFormFieldType.phone:
        signUpModel?.phone = newValue;
        break;
      case CustomTextFormFieldType.dateOfBirth:
        signUpModel?.date = newValue;
        break;
      default:
        break;
    }
  }
}
