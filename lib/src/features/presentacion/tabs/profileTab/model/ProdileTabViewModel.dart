import 'package:app_delivery/src/features/logica/CasosDeUso/Auth/SingOutUseCase/SingOutUseCase.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';

abstract class ProfileTabViewModelInput {
  late LoadingStateProvider loadingStatusState;
  Future<void> singOut();
  void initState({required LoadingStateProvider loadingState});
}

abstract class ProfileTabViewModel extends ProfileTabViewModelInput {}

class DefaultProfileTabViewModel extends ProfileTabViewModel {
  //DEPENDENCIA
  final SingOutUseCase _singOutUseCase;

  DefaultProfileTabViewModel({SingOutUseCase? singOutUseCase})
      : _singOutUseCase = singOutUseCase ?? DefaultSingOutUseCase();
  @override
  void initState({required LoadingStateProvider loadingState}) {
    loadingStatusState = loadingState;
  }

  @override
  Future<void> singOut() {
    return _singOutUseCase.execute().then((value) => loadingStatusState.setLoadingState(isLoading: false));
  }
}
