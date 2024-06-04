import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:app_delivery/src/services/GeolocationService/Interface/GeolocationServiceInterfaces.dart';
import 'package:app_delivery/src/services/GeolocationService/Mappers/GeolocationServiceMappers.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/GeolocationService.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:geolocator/geolocator.dart';

class MockGeolocationService extends GeolocationService {
  @override
  Future<Result<PositionEntity, Failure>> getCurrentPosition() async {
    final permsionStatus = await getPermisionStatus();
    if (permsionStatus == LocationPermissionStatus.allowed) {
      var fakePosition = Position(
          latitude: 41.386400,
          longitude: 2.169188,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0);
      return Result.succes(GeolocationServiceMappers.mapPosition(fakePosition));
    } else {
      return Future.error(GeolocationErrorsMessages.locationPermissionDenied);
    }
  }

  @override
  Future<LocationPermissionStatus> getPermisionStatus() async {
    return LocationPermissionStatus.allowed;
  }
}
