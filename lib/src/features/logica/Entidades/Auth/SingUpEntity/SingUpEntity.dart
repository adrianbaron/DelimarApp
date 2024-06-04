import 'dart:convert';

SingUpEntity singUpEntityFromJson(String str) =>
    SingUpEntity.fromJson(json.decode(str));

String singUpEntityToJson(SingUpEntity data) =>
    json.encode(data.toJson());

class SingUpEntity {
  String kind;
  String idToken;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;

  SingUpEntity({
    required this.kind,
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.localId,
  });

  factory SingUpEntity.fromJson(Map<String, dynamic> json) => SingUpEntity(
        kind: json["kind"],
        idToken: json["idToken"],
        email: json["email"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        localId: json["localId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "idToken": idToken,
        "email": email,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "localId": localId,
      };
}
