import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Decorables/DeliveryAddress/deliver_address_decodable.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/features/data/Repositories/DeliveryAddress/DeliveryAddressBodyParameters/delivery_address_body_parameters.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';

class DefaultDeliveryAddressRepository extends DeliveryAddressRepository {
  final String _path = "deliveryAddressList/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultDeliveryAddressRepository(
      {RealtimeDataBaseService? realtimeDataBaseService})
      : _realtimeDataBaseService =
            realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<DeliveryAddressListDecodable> getDeliveryAddressList(
      {required String localId}) async {
    try {
      final response =
          await _realtimeDataBaseService.getData(path: _path + localId);
      return DeliveryAddressListDecodable.fromMap(response);
    } on Failure catch (f) {
      if (f.message == RealtimeDatabaseExceptions.httpException) {
        return DeliveryAddressListDecodable.getEmptyPaymentMethods();
      } else {
        return Future.error(Failure.fromMessage(
            message: AppFailureMessages.unExpectedErrorMessage));
      }
    }
  }

  @override
  Future<DeliveryAddressListDecodable> saveDeliveryAddressList(
      {required String localId,
      required DeliveryAddressListBodyParameters bodyParameters}) async {
    var path = _path + localId;
    try {
      final result = await _realtimeDataBaseService.putData(
          bodyParameters: bodyParameters.toMap(), path: path);
      return DeliveryAddressListDecodable.fromMap(result);
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }
}
