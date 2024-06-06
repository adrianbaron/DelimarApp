import 'package:app_delivery/src/Base/APIservice/ApiService.dart';
import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';

abstract class RealtimeDatabaseExceptions {
  static const String socketExceptionMessage = "No Internet connection 😑";
  static const String httpException = "Couldn't find the path 😱";
  static const String formatException = "Bad response format 👎";
}

class DefaultRealtimeDatabaseService extends RealtimeDataBaseService {
  final ApiService _apiService;

  DefaultRealtimeDatabaseService({ApiService? apiService})
      : _apiService = apiService ?? DefaultApiService();

  @override
  Future<Map<String, dynamic>> getData({required String path}) async {
    var endpoint = baseUrl + path + endUrl;
    print(endpoint);
    try {
      final result = await _apiService.getDataFromGetRequest(url: endpoint);
      return result;
    } on Failure catch (f) {
      switch (f.message) {
        case RealtimeDatabaseExceptions.httpException:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.httpException));
        case RealtimeDatabaseExceptions.formatException:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.formatException));
        case RealtimeDatabaseExceptions.socketExceptionMessage:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.socketExceptionMessage));
        default:
          return f.error;
      }
    }
  }

  @override
  Future<Map<String, dynamic>> putData(
      {required Map<String, dynamic> bodyParameters,
      required String path}) async {
    var endpoint = baseUrl + path + endUrl;
    try {
      final result = await _apiService.getDataFromPutRequest(
          bodyParameters: bodyParameters, url: endpoint);
      return result;
    } on Failure catch (f) {
      switch (f.message) {
        case RealtimeDatabaseExceptions.httpException:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.httpException));
        case RealtimeDatabaseExceptions.formatException:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.formatException));
        case RealtimeDatabaseExceptions.socketExceptionMessage:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.socketExceptionMessage));
        default:
          return f.error;
      }
    }
  }

  @override
  Future<Map<String, dynamic>> postData(
      {required Map<String, dynamic> bodyParameters,
      required String path}) async {
    var endpoint = baseUrl + path + endUrl;
    try {
      final result = await _apiService.getDataFromPostRequest(
          bodyParameters: bodyParameters, url: endpoint);
      return result;
    } on Failure catch (f) {
      switch (f.message) {
        case RealtimeDatabaseExceptions.httpException:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.httpException));
        case RealtimeDatabaseExceptions.formatException:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.formatException));
        case RealtimeDatabaseExceptions.socketExceptionMessage:
          return Future.error(Failure.fromMessage(
              message: RealtimeDatabaseExceptions.socketExceptionMessage));
        default:
          return f.error;
      }
    }
  }
}
