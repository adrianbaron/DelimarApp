import 'package:app_delivery/src/services/GeolocationService/Entities/GeolocationServiceEntities.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationServiceMappers {
  static PositionEntity mapPosition(Position position) {
    //
    print("Longitud: ${position.longitude}");
    print("Latitude: ${position.latitude}");

    return PositionEntity(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: position.timestamp,
        accuracy: position.accuracy,
        altitude: position.altitude,
        heading: position.heading,
        speed: position.speed,
        speedAccuracy: position.speedAccuracy);
  }
}
