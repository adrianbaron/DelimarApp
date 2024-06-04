import 'dart:convert';

SingInDecorable singInDecorableFromJson(String str) =>
    SingInDecorable.fromJson(json.decode(str));

String singInDecorableToJson(SingInDecorable data) =>
    json.encode(data.toJson());

class SingInDecorable {
  String kind;
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;

  SingInDecorable({
    required this.kind,
    required this.localId,
    required this.email,
    required this.displayName,
    required this.idToken,
    required this.registered,
  });

  factory SingInDecorable.fromJson(Map<String, dynamic> json) =>
      SingInDecorable(
        kind: json["kind"],
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        idToken: json["idToken"],
        registered: json["registered"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "idToken": idToken,
        "registered": registered,
      };
}
