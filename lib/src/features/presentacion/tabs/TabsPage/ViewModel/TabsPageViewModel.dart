import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Geolocation/GeolocationUseCase.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class TabsPageViewModelInput {
  Future<Result<bool, Failure>> getCurrentPosition();
  Future<LocationPermissionStatus> getPermisionStatus();
}

abstract class TabsPageViewModel extends TabsPageViewModelInput
    with BaseViewModel {}

class DefaultTabsPageViewModel extends TabsPageViewModel {
  //DEPENDENCIAS
  final GeolocationUseCase _geolocationUseCase;

  DefaultTabsPageViewModel({GeolocationUseCase? geolocationUseCase})
      : _geolocationUseCase = geolocationUseCase ?? DefaultGeolocationUseCase();
  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
  }

  @override
  Future<Result<bool, Failure>> getCurrentPosition() async {
    return await _geolocationUseCase.getCurrentPosition().then((result) {
      switch (result.status) {
        case ResultStatus.success:
          return Result.succes(true);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }

  @override
  Future<LocationPermissionStatus> getPermisionStatus() {
    return _geolocationUseCase.getPermisionStatus();
  }
}
