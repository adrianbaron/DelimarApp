import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:app_delivery/src/services/GeolocationService/Interface/GeolocationServiceInterfaces.dart';
import 'package:app_delivery/src/services/GeolocationService/Mappers/GeolocationServiceMappers.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeolocationErrorsMessages {
  static const String locationServicesDisabled =
      "Locations services are disable";
  static const String locationPermissionDenied =
      "You have denied access to your location. Please enable it to continue";
  static const String locationPermissionDeniedForever =
      "You have denied access to your location. Please enable it to continue";
}

class DefaultGeolocationService extends GeolocationService {
  @override
  Future<LocationPermissionStatus> getPermisionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
        return LocationPermissionStatus.denied;
      case LocationPermission.deniedForever:
        return LocationPermissionStatus.deniedForever;
      case LocationPermission.whileInUse:
        return LocationPermissionStatus.allowed;
      case LocationPermission.always:
        return LocationPermissionStatus.allowed;
      case LocationPermission.unableToDetermine:
        return LocationPermissionStatus.denied;
    }
  }

  @override
  Future<Result<PositionEntity, Failure>> getCurrentPosition() async {
    return await _determinePosition().then((position) {
      return Result.succes(GeolocationServiceMappers.mapPosition(position));
    }, onError: (e) {
      return Result.failure(Failure.fromMessage(message: e.toString()));
    });
  }
}

extension PrivateMethods on DefaultGeolocationService {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(GeolocationErrorsMessages.locationServicesDisabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(GeolocationErrorsMessages.locationPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          GeolocationErrorsMessages.locationPermissionDeniedForever);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
