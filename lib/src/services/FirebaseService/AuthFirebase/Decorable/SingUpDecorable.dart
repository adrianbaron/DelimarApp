import 'dart:convert';

SingUpDecorable singUpDecorableFromJson(String str) =>
    SingUpDecorable.fromJson(json.decode(str));

String singUpDecorableToJson(SingUpDecorable data) =>
    json.encode(data.toJson());

class SingUpDecorable {
  String kind;
  String idToken;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;

  SingUpDecorable({
    required this.kind,
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.localId,
  });

  factory SingUpDecorable.fromJson(Map<String, dynamic> json) =>
      SingUpDecorable(
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
