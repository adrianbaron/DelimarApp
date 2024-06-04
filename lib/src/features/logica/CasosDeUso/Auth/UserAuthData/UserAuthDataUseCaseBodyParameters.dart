import 'dart:convert';

GetUserDataUseCaseBodyParameters getUserDataBodyParametersFromJson(
        String str) =>
    GetUserDataUseCaseBodyParameters.fromJson(json.decode(str));

String getUserDataBodyParametersToJson(GetUserDataUseCaseBodyParameters data) =>
    json.encode(data.toJson());

class GetUserDataUseCaseBodyParameters {
  String idToken;

  GetUserDataUseCaseBodyParameters({
    required this.idToken,
  });

  factory GetUserDataUseCaseBodyParameters.fromJson(
          Map<String, dynamic> json) =>
      GetUserDataUseCaseBodyParameters(
        idToken: json["idToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
      };
}
