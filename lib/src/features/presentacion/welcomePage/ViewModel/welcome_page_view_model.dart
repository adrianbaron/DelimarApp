import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/GoogleSignInUseCase/GoogleSignInUseCase.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class WelcomePageViewModelInput {
  Future<Result<UserEntity,Failure>> signInWithGoogle();
}

abstract class WelcomePageViewModel extends WelcomePageViewModelInput with BaseViewModel {}

class DefaultWelcomePageViewModel extends WelcomePageViewModel {

  // Dependencias
  final GoogleSignInUseCase _googleSignInUseCase;

  DefaultWelcomePageViewModel({
    GoogleSignInUseCase? googleSignInUseCase
  }) : _googleSignInUseCase = googleSignInUseCase ?? DefaultGoogleSignInUseCase();

  @override
  Future<Result<UserEntity,Failure>> signInWithGoogle() {
    return _googleSignInUseCase.execute();
  }

  @override
  void initState({required LoadingStateProvider loadingState}) {
    loadingStatusState = loadingState;
  }
}