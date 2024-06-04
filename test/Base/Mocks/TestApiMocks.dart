import 'dart:convert';

CorrectPostBodyParameters correctPostBodyParametersFromJson(String str) => CorrectPostBodyParameters.fromJson(json.decode(str));

String correctPostBodyParametersToJson(CorrectPostBodyParameters data) => json.encode(data.toJson());

class CorrectPostBodyParameters {
    String tittle;
    String boody;
    int userId;

    CorrectPostBodyParameters({
        required this.tittle,
        required this.boody,
        required this.userId,
    });

    factory CorrectPostBodyParameters.fromJson(Map<String, dynamic> json) => CorrectPostBodyParameters(
        tittle: json["tittle"],
        boody: json["boody"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "tittle": tittle,
        "boody": boody,
        "userId": userId,
    };
}

CorrectPutBodyParameters correctPutBodyParametersFromJson(String str) => CorrectPutBodyParameters.fromJson(json.decode(str));

String correctPutBodyParametersToJson(CorrectPutBodyParameters data) => json.encode(data.toJson());

class CorrectPutBodyParameters {
    int id;
    String tittle;
    String boody;
    int userId;

    CorrectPutBodyParameters({
        required this.id,
        required this.tittle,
        required this.boody,
        required this.userId,
    });

    factory CorrectPutBodyParameters.fromJson(Map<String, dynamic> json) => CorrectPutBodyParameters(
        id: json["id"],
        tittle: json["tittle"],
        boody: json["boody"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": tittle,
        "boody": boody,
        "userId": userId,
    };
}