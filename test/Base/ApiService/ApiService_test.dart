import 'package:app_delivery/src/Base/APIservice/ApiService.dart';
import 'package:flutter_test/flutter_test.dart';

import '../Mocks/TestApiMocks.dart';

abstract class _Constants {
  static Map<String, String> defaultHeaders = {
    'Content-type': 'application/json; charset=UTF-8'
  };
  static String postEndPoint = "https://jsonplaceholder.typicode.com/posts";
  static String getEndPoint = "https://jsonplaceholder.typicode.com/posts/1";
  static String putEndPoint = 'https://jsonplaceholder.typicode.com/posts/1';
}

void main() {
  //Lo que estoy testeando jajaja
  final ApiService _testApiService = DefaultApiService();

//grupo de tests para las difrentes conexiones
  group("Test pata comprobar conexion", () {
    //Test conexion post
    test("Test post connection to json Placeholder", () async {
      final bodyParams = CorrectPostBodyParameters(
          tittle: "Langostas", boody: "asadas", userId: 1);
      final result = await _testApiService.getDataFromPostRequest(
          bodyParameters: bodyParams.toJson(),
          url: _Constants.postEndPoint,
          headers: _Constants.defaultHeaders);

      expect(result, Map.from(result));
    });
//Test get conexion
    test("Test correct get connection", () async {
      final result = await _testApiService.getDataFromGetRequest(
          url: _Constants.getEndPoint);
      expect(result, Map.from(result));
    });

//Test put
    test("Test correct put connection", () async {
      final body = CorrectPutBodyParameters(
          id: 1, tittle: "comida", boody: "mar", userId: 1);
      final result = await _testApiService.getDataFromPutRequest(
          bodyParameters: body.toJson(),
          url: _Constants.putEndPoint,
          headers: _Constants.defaultHeaders);
      expect(result, Map.from(result));
    });
  });
}
