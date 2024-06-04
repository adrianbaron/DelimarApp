abstract class BaseRealTimeDataBaseFirebase {
  String baseUrl = "https://delmarapp-cfeed-default-rtdb.firebaseio.com/";
  String endUrl = ".json";
  String adminToken = "AIzaSyCa15EBWaFZnIPFaAMM23QbgRwtoKFBd8I";
}

abstract class RealtimeDataBaseService extends BaseRealTimeDataBaseFirebase {
  Future<Map<String, dynamic>> postData(
      {required Map<String, dynamic> bodyParameters, required String path});
  Future<Map<String, dynamic>> putData(
      {required Map<String, dynamic> bodyParameters, required String path});
  Future<Map<String, dynamic>> getData({required String path});
}
