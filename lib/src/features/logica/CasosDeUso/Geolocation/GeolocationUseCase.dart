import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/logica/CasosDeUso/Geolocation/GeolocationUseCaseParameters.dart';
import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:app_delivery/src/services/GeolocationService/Interface/GeolocationServiceInterfaces.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/GeolocationService.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/GeolocationServiceHelper.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class GeolocationUseCase {
  Future<Result<PositionEntity, Failure>> getCurrentPosition();
  Future<LocationPermissionStatus> getPermisionStatus();
  Future<double> getDistanceBetweenYourCurrentPositionAnd(
      Destination destination);
}

class DefaultGeolocationUseCase extends GeolocationUseCase {
  //DEPENDENCIAS
  final GeolocationService _geolocationService;
  final GeolocationServiceHelper _geolocationServiceHelper;

  DefaultGeolocationUseCase(
      {GeolocationService? geolocationService,
      GeolocationServiceHelper? geolocationServiceHelper})
      : _geolocationService = geolocationService ?? DefaultGeolocationService(),
        _geolocationServiceHelper =
            geolocationServiceHelper ?? DefaultGeolocatiionServiceHelper();
  @override
  Future<Result<PositionEntity, Failure>> getCurrentPosition() {
    return _geolocationService.getCurrentPosition();
  }

  @override
  Future<double> getDistanceBetweenYourCurrentPositionAnd(
      Destination destination) async {
    final userPosition = await _geolocationService.getCurrentPosition();
    return _geolocationServiceHelper.getDistanceBetweenInKilometers(
        userPosition.value?.latitude ?? 0.0,
        userPosition.value?.longitude ?? 0.0,
        destination.destinationLatitude,
        destination.destinationLongitude);
  }

  @override
  Future<LocationPermissionStatus> getPermisionStatus() {
    return _geolocationService.getPermisionStatus();
  }
}
