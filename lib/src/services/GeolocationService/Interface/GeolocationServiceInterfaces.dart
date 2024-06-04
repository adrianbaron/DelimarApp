import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

abstract class GeolocationService {
  Future<Result<PositionEntity, Failure>> getCurrentPosition();
  Future<LocationPermissionStatus> getPermisionStatus();
}

abstract class GeolocationServiceHelper {
  double getDistanceBetweenInMeters(double starlatitude, double starlongitude,
      double destinationlatitude, double destinationlongitude);
  double getDistanceBetweenInKilometers(
      double starlatitude,
      double starlongitude,
      double destinationlatitude,
      double destinationlongitude);
}
