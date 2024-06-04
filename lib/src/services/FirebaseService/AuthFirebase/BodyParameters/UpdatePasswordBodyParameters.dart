import 'dart:convert';

UpdatePasswordBodyParameters updatePasswordBodyParametersFromJson(String str) => UpdatePasswordBodyParameters.fromJson(json.decode(str));

String updatePasswordBodyParametersToJson(UpdatePasswordBodyParameters data) => json.encode(data.toJson());

class UpdatePasswordBodyParameters {
    String email;
    String requestType;

    UpdatePasswordBodyParameters({
        required this.email,
        required this.requestType,
    });

    factory UpdatePasswordBodyParameters.fromJson(Map<String, dynamic> json) => UpdatePasswordBodyParameters(
        email: json["email"],
        requestType: json["requestType"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "requestType": requestType,
    };
}
