import 'dart:convert';

GetUserDataBodyParameters getUserDataBodyParametersFromJson(String str) => GetUserDataBodyParameters.fromJson(json.decode(str));

String getUserDataBodyParametersToJson(GetUserDataBodyParameters data) => json.encode(data.toJson());

class GetUserDataBodyParameters {
    String idToken;

    GetUserDataBodyParameters({
        required this.idToken,
    });

    factory GetUserDataBodyParameters.fromJson(Map<String, dynamic> json) => GetUserDataBodyParameters(
        idToken: json["idToken"],
    );

    Map<String, dynamic> toJson() => {
        "idToken": idToken,
    };
}
