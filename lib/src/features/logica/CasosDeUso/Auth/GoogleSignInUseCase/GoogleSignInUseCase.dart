import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/LocalStorageKey.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/SaveLocalStorageUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/LocalStorage/local_Storage_UseCase_Parameters.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCase.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/User/SaveUserDataUseCase/SaveUserDataUseCaseParameters.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/services/GoogleSingInService/Entities/GoogleSignInUserEntity.dart';
import 'package:app_delivery/src/services/GoogleSingInService/Interfaces/interface.dart';
import 'package:app_delivery/src/services/GoogleSingInService/services/GoogleSingInService.dart';
import 'package:app_delivery/src/utils/helpers/Dates/datesHelpers.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class GoogleSignInUseCase {
  Future<Result<UserEntity, Failure>> execute();
}

class DefaultGoogleSignInUseCase extends GoogleSignInUseCase {
  //Dependencia
  final GoolgleSignInService _goolgleSignInService;
  final SaveLocalStorageUseCase _localStorageUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  DefaultGoogleSignInUseCase(
      {GoolgleSignInService? goolgleSignInService,
      SaveLocalStorageUseCase? localStorageUseCase,
      SaveUserDataUseCase? saveUserDataUseCase})
      : _goolgleSignInService =
            goolgleSignInService ?? DefaultGoogleSignInService(),
        _localStorageUseCase =
            localStorageUseCase ?? DefaultSaveLocalStorageUseCase(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase();

  @override
  Future<Result<UserEntity, Failure>> execute() async {
    //Hacer el google signIn
    final user = await _goolgleSignInService.signInWithGoogle();
    //Mantenser sesion
    _localStorageUseCase.execute(
        parameters: SaveLocalStorageParameters(
            key: LocalStorageKeys.idToken, value: user.idToken ?? ""));
    final isUserInDataBase =
        await _goolgleSignInService.isUserInDatabase(uid: user.uid ?? "");
    if (isUserInDataBase) {
      return Result.succes(_mapUserEntity(user: user));
    } else {
      return _saveUserInDataBase(user: user);
    }
  }
}

extension Mapper on DefaultGoogleSignInUseCase {
  UserEntity _mapUserEntity({required GoogleSignInUserEntity user}) {
    return UserEntity(
        localId: user.uid,
        role: UserRole.user.toShortString(),
        username: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        dateOfBirth: "",
        startDate: DateHelpers.getStarDate(),
        photo: user.photoURL,
        shippingAddress: "",
        billingAddress: "",
        idToken: user.idToken);
  }
}

extension PrivateMethods on DefaultGoogleSignInUseCase {
  Future<Result<UserEntity, Failure>> _saveUserInDataBase(
      {required GoogleSignInUserEntity user}) {
    final SaveUserDataUseCaseParameters params = SaveUserDataUseCaseParameters(
        localId: user.uid,
        role: UserRole.user,
        username: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        dateOfBirth: "",
        startDate: DateHelpers.getStarDate(),
        photo: user.photoURL,
        shippingAddress: "",
        billingAddress: "",
        idToken: user.idToken);

    return _saveUserDataUseCase.execute(parameters: params);
  }
}
