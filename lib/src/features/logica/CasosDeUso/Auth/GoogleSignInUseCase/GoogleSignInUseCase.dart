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

  // Dependencies
  final GoolgleSignInService _googleSignInService;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  DefaultGoogleSignInUseCase({
    GoolgleSignInService? googleSignInService,
    SaveLocalStorageUseCase? saveLocalStorageUseCase,
    SaveUserDataUseCase? saveUserDataUseCase
  }) : _googleSignInService = googleSignInService ?? DefaultGoogleSignInService(),
       _saveLocalStorageUseCase = saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase(),
        _saveUserDataUseCase = saveUserDataUseCase ?? DefaultSaveUserDataUseCase();

  @override
  Future<Result<UserEntity, Failure>> execute() async {
    final user = await _googleSignInService.signInWithGoogle();
    _saveLocalStorageUseCase.execute(saveLocalParameteres: SaveLocalStorageParameters(key: LocalStorageKeys.idToken,
                                                                                      value: user.uid ?? ""));

    final isUserInDatabase = await _googleSignInService.isUserInDatabase(uid: user.uid ?? "");
    if (isUserInDatabase) {
      return Result.succes(mapUserEntity(user:user));
    } else {
      return _saveUserDataInDataBase(user: user);
    }
  }
}

extension on DefaultGoogleSignInUseCase {
  Future<Result<UserEntity, Failure>> _saveUserDataInDataBase({ required GoogleSignInUserEntity user }) {

    SaveUserDataUseCaseParameters _params = SaveUserDataUseCaseParameters(
        localId: user.uid,
        role: UserRole.user,
        username: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        dateOfBirth: "",
        startDate: DateHelpers.getStarDate(),
        photo: user.photoURL,
        shippingAddress: '',
        billingAddress: '',
        idToken: user.idToken,
        provider: UserAuthProvider.google);

    return _saveUserDataUseCase.execute(parameters: _params);
  }

  UserEntity mapUserEntity({ required GoogleSignInUserEntity user }) {
    return UserEntity(
        localId: user.uid,
        role: UserRole.user.toShortString(),
        username: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        dateOfBirth: "",
        startDate: DateHelpers.getStarDate(),
        photo: user.photoURL,
        shippingAddress: '',
        billingAddress: '',
        idToken: user.refreshToken,
        provider: UserAuthProvider.google
    );
  }
}
