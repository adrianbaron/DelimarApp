import 'dart:convert';
import 'dart:io';
import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/utils/helpers/Logger/logger.dart';
import 'package:http/http.dart' as http;

abstract class _Exceptions {
  static String socketExceptionMessage = "No Internet connection 😑";
  static String httpException = "Couldn't find the path 😱";
  static String formatException = "Bad response format 👎";
}

abstract class ApiService {
  Future<Map<String, dynamic>> getDataFromPostRequest(
      {required Map<String, dynamic> bodyParameters,
      required String url,
      Map<String, String>? headers});
  Future<Map<String, dynamic>> getDataFromPutRequest(
      {required Map<String, dynamic> bodyParameters,
      required String url,
      Map<String, String>? headers});
  Future<Map<String, dynamic>> getDataFromGetRequest(
      {required String url, Map<String, String>? headers});
}

class DefaultApiService extends ApiService {
  @override
  Future<Map<String, dynamic>> getDataFromGetRequest(
      {required String url, Map<String, String>? headers}) async {
    var _url = Uri.parse(url);
    var response = await http.get(_url, headers: headers);

    Logger.printRequest(url: url, method: Method.get, headers: headers);

    try {
      Logger.printRespone(
          url: url, method: Method.get, response: response, headers: headers);

      if (response.statusCode.toString().contains('20')) {
        var jsonData = jsonDecode(response.body);
        // Null Check
        if (jsonData == null) {
          throw Failure.fromMessage(message: _Exceptions.httpException);
        } else {
          return jsonData;
        }
      } else {
        throw Failure.fromBody(body: response.body);
      }
    } on SocketException {
      throw Failure.fromMessage(message: _Exceptions.socketExceptionMessage);
    } on HttpException {
      throw Failure.fromMessage(message: _Exceptions.httpException);
    } on FormatException {
      throw Failure.fromMessage(message: _Exceptions.formatException);
    }
  }

  @override
  Future<Map<String, dynamic>> getDataFromPostRequest(
      {required Map<String, dynamic> bodyParameters,
      required String url,
      Map<String, String>? headers}) async {
    var _url = Uri.parse(url);
    var body = json.encode(bodyParameters);
    var response = await http.post(_url, headers: headers, body: body);

    Logger.printRequest(
        url: url,
        method: Method.post,
        bodyParameters: bodyParameters,
        headers: headers);

    try {
      Logger.printRespone(
          url: url, method: Method.post, response: response, headers: headers, bodyParameters: bodyParameters);

      if (response.statusCode.toString().contains('20')) {
        var jsonData = jsonDecode(response.body);
        // Null Check
        if (jsonData == null) {
          throw Failure.fromMessage(message: _Exceptions.httpException);
        } else {
          return jsonData;
        }
      } else {
        throw Failure.fromBody(body: response.body);
      }
    } on SocketException {
      throw Failure.fromMessage(message: _Exceptions.socketExceptionMessage);
    } on HttpException {
      throw Failure.fromMessage(message: _Exceptions.httpException);
    } on FormatException {
      throw Failure.fromMessage(message: _Exceptions.formatException);
    }
  }

  @override
  Future<Map<String, dynamic>> getDataFromPutRequest(
      {required Map<String, dynamic> bodyParameters,
      required String url,
      Map<String, String>? headers}) async {
    var _url = Uri.parse(url);
    var body = json.encode(bodyParameters);
    var response = await http.put(_url, headers: headers, body: body);

    Logger.printRequest(
        url: url,
        method: Method.get,
        bodyParameters: bodyParameters,
        headers: headers);
        
    try {
      Logger.printRespone(
          url: url, method: Method.put, response: response, headers: headers, bodyParameters: bodyParameters);

      if (response.statusCode.toString().contains('20')) {
        var jsonData = jsonDecode(response.body);
        // Null Check
        if (jsonData == null) {
          throw Failure.fromMessage(message: _Exceptions.httpException);
        } else {
          return jsonData;
        }
      } else {
        throw Failure.fromBody(body: response.body);
      }
    } on SocketException {
      throw Failure.fromMessage(message: _Exceptions.socketExceptionMessage);
    } on HttpException {
      throw Failure.fromMessage(message: _Exceptions.httpException);
    } on FormatException {
      throw Failure.fromMessage(message: _Exceptions.formatException);
    }
  }
}

