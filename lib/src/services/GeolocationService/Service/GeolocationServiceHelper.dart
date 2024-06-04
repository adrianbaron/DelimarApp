import 'package:app_delivery/src/services/GeolocationService/Interface/GeolocationServiceInterfaces.dart';
import 'package:geolocator/geolocator.dart';

class DefaultGeolocatiionServiceHelper extends GeolocationServiceHelper {
  @override
  double getDistanceBetweenInKilometers(
      double starlatitude,
      double starlongitude,
      double destinationlatitude,
      double destinationlongitude) {
    return Geolocator.distanceBetween(starlatitude, starlongitude,
            destinationlatitude, destinationlongitude) /
        1000;
  }

  @override
  double getDistanceBetweenInMeters(double starlatitude, double starlongitude,
      double destinationlatitude, double destinationlongitude) {
    return Geolocator.distanceBetween(
        starlatitude, starlongitude, destinationlatitude, destinationlongitude);
  }
}
