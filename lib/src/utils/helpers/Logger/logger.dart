/*
 Para pintar en consola con un color específico usamos los Ansi Colors Codes
 Para más códigos de color puedes buscar info aquí:
 https://www.codegrepper.com/code-examples/java/ansi+colors
*/
import 'package:http/http.dart';
import 'dart:convert';

enum Method { get, post, put, delete }

class Logger {
  static printMessageOnConsole(String message, String? keyword) {
    print('\x1B[33mDELIVERY- ${keyword ?? ""} - ${message}\x1B[0m');
  }

  static printErrorOnConsole(String message, String? keyword) {
    print('\x1B[31mDELIVERY- ${keyword ?? ""} - ${message}\x1B[0m');
  }

  static printRequest(
      {required String url,
      required Method method,
      Map<String, String>? headers,
      Map<String, dynamic>? bodyParameters}) {
    var encoder = JsonEncoder.withIndent('  ');
    print("\n\n---------- REQUEST ---------->>>\n\n");
    print("URL: $url");
    print("Method: ${method.name}");
    if (headers != null && headers.isNotEmpty) {
      print("Headers: ${encoder.convert(headers)}");
    }
    if (bodyParameters != null && bodyParameters.isNotEmpty) {
      print("Body Parameters: ${encoder.convert(bodyParameters)}");
    }
    print("\n------------------------->>>\n\n");
  }

  static printRespone(
      {required String url,
      required Method method,
      required Response response,
      Map<String, String>? headers,
      Map<String, dynamic>? bodyParameters}) {
    var encoder = JsonEncoder.withIndent('  ');
    print("\n\n<<<---------- RESPONSE ----------\n\n");
    print("URL: $url");
    print("Method: ${method.name}");
    if (headers != null && headers.isNotEmpty) {
      print("Headers: ${encoder.convert(headers)}");
    }
    if (bodyParameters != null && bodyParameters.isNotEmpty) {
      print("Body Parameters: ${encoder.convert(bodyParameters)}");
    }
    print(response.statusCode.toString());
    if (response.body.isNotEmpty) {
      print(response.body);
    }
    print("\n<<<--------------------\n\n");
  }
}
