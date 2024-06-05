import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Geolocation/GeolocationUseCase.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';



abstract class TabsViewModelInput {
  // Exposed Methods
  Future<Result<bool,Failure>> getCurrentPosition();
  Future<LocationPermissionStatus> getPermissionStatus();
}

mixin TabsViewModelOutput {}

// Crear ViewModel
abstract class TabsViewModel extends TabsViewModelInput with TabsViewModelOutput, BaseViewModel {}

class DefaultTabsViewModel extends TabsViewModel {
  // Dependencies
  final GeolocationUseCase _geolocationUseCase;

  DefaultTabsViewModel({ GeolocationUseCase? geolocationUseCase })
      : _geolocationUseCase = geolocationUseCase ?? DefaultGeolocationUseCase();

  @override
  void initState({ required LoadingStateProvider loadingState }) {
    loadingStatusState = loadingState;
  }

  @override
  Future<Result<bool, Failure>> getCurrentPosition() async {

    return await _geolocationUseCase.getCurrentPosition().then( (result) {
      switch (result.status) {
        case ResultStatus.success:
          return Result.succes(true);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }

  Future<LocationPermissionStatus> getPermissionStatus() async {
    return await _geolocationUseCase.getPermisionStatus();
  }
}

