import 'package:app_delivery/src/Base/APIservice/ApiService.dart';
import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/services/FirebaseService/RealTimeDataBaseService/Interfaces/interfaces.dart';

class DefaultRealtimeDatabaseService extends RealtimeDataBaseService {
  final ApiService _apiService;

  DefaultRealtimeDatabaseService({ApiService? apiService})
      : _apiService = apiService ?? DefaultApiService();

  @override
  Future<Map<String, dynamic>> getData({required String path}) async {
    print("Entramos al metodo getData de RealtimeDatabaseService");
    var endpoint = baseUrl + path + endUrl;
    print('URL: $endpoint');
    try {
      final result = await _apiService.getDataFromGetRequest(url: endpoint);
      
      //print('Resultado: $result');
      return result;
      
    } on Failure catch (f) {
      //print('Error en getData: ${f.error}');
      return f.error;
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
      return f.error;
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
      return f.error;
    }
  }
}
