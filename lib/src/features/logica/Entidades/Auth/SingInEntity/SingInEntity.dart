import 'dart:convert';

SingInEntity singInEntityFromJson(String str) => SingInEntity.fromJson(json.decode(str));

String singInEntityToJson(SingInEntity data) => json.encode(data.toJson());

class SingInEntity {
    String ? localId;
    String ? email;
    String ?displayName;
    String ?idToken;
    bool ?registered;
    String ?refreshToken;
    String ?expiresdIn;

    SingInEntity({
        required this.localId,
        required this.email,
        required this.displayName,
        required this.idToken,
        required this.registered,
        required this.refreshToken,
        required this.expiresdIn,
    });

    factory SingInEntity.fromJson(Map<String, dynamic> json) => SingInEntity(
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        idToken: json["idToken"],
        registered: json["registered"],
        refreshToken: json["refreshToken"],
        expiresdIn: json["expiresdIn"],
    );

    Map<String, dynamic> toJson() => {
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "idToken": idToken,
        "registered": registered,
        "refreshToken": refreshToken,
        "expiresdIn": expiresdIn,
    };
}