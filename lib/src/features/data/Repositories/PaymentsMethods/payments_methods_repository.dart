import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/features/data/Decorables/PaymentMethods/payments_methods_decodable.dart';
import 'package:app_delivery/src/features/data/Interfaces/interfaces.dart';
import 'package:app_delivery/src/features/data/Repositories/PaymentsMethods/BodyParameters/payments_methods_body_parameters.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Services/realTimeDatabaseService.dart';

class DefaultPaymentMethodsRepository extends PaymentMethodsRepository {
  final String _path = "paymentMethods/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultPaymentMethodsRepository(
      {RealtimeDataBaseService? realtimeDataBaseService})
      : _realtimeDataBaseService =
            realtimeDataBaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<PaymentMethodsDecodable> getPaymentMethods(
      {required String localId}) async {
    try {
      final response =
          await _realtimeDataBaseService.getData(path: _path + localId);
      return PaymentMethodsDecodable.fromMap(response);
    } on Failure catch (f) {
      if (f.message == RealtimeDatabaseExceptions.httpException) {
        return PaymentMethodsDecodable.getEmptyPaymentMethods();
      } else {
        return Future.error(Failure.fromMessage(
            message: AppFailureMessages.unExpectedErrorMessage));
      }
    }
  }

  @override
  Future<PaymentMethodsDecodable> savePaymentMethods(
      {required String localId,
      required PaymentMethodsBodyParameters bodyParameters}) async {
    var path = _path + localId;
    try {
      final result = await _realtimeDataBaseService.putData(
          bodyParameters: bodyParameters.toMap(), path: path);
      return PaymentMethodsDecodable.fromMap(result);
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }
}
