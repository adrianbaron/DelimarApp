import 'dart:convert';

UserAuthDataEntity userAuthDataEntityFromJson(String str) => UserAuthDataEntity.fromJson(json.decode(str));

String userAuthDataEntityToJson(UserAuthDataEntity data) => json.encode(data.toJson());

class UserAuthDataEntity {
    List<User> users;

    UserAuthDataEntity({
        required this.users,
    });

    factory UserAuthDataEntity.fromJson(Map<String, dynamic> json) => UserAuthDataEntity(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}

class User {
    String localId;
    String email;
    bool emailVerified;
    String displayName;
    List<ProviderUserInfo> providerUserInfo;
    String photoUrl;
    String passwordHash;
    int passwordUpdatedAt;
    String validSince;
    bool disabled;
    String lastLoginAt;
    String createdAt;
    bool customAuth;

    User({
        required this.localId,
        required this.email,
        required this.emailVerified,
        required this.displayName,
        required this.providerUserInfo,
        required this.photoUrl,
        required this.passwordHash,
        required this.passwordUpdatedAt,
        required this.validSince,
        required this.disabled,
        required this.lastLoginAt,
        required this.createdAt,
        required this.customAuth,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        localId: json["localId"],
        email: json["email"],
        emailVerified: json["emailVerified"],
        displayName: json["displayName"],
        providerUserInfo: List<ProviderUserInfo>.from(json["providerUserInfo"].map((x) => ProviderUserInfo.fromJson(x))),
        photoUrl: json["photoUrl"],
        passwordHash: json["passwordHash"],
        passwordUpdatedAt: json["passwordUpdatedAt"],
        validSince: json["validSince"],
        disabled: json["disabled"],
        lastLoginAt: json["lastLoginAt"],
        createdAt: json["createdAt"],
        customAuth: json["customAuth"],
    );

    Map<String, dynamic> toJson() => {
        "localId": localId,
        "email": email,
        "emailVerified": emailVerified,
        "displayName": displayName,
        "providerUserInfo": List<dynamic>.from(providerUserInfo.map((x) => x.toJson())),
        "photoUrl": photoUrl,
        "passwordHash": passwordHash,
        "passwordUpdatedAt": passwordUpdatedAt,
        "validSince": validSince,
        "disabled": disabled,
        "lastLoginAt": lastLoginAt,
        "createdAt": createdAt,
        "customAuth": customAuth,
    };
}

class ProviderUserInfo {
    String providerId;
    String displayName;
    String photoUrl;
    String federatedId;
    String email;
    String rawId;
    String screenName;

    ProviderUserInfo({
        required this.providerId,
        required this.displayName,
        required this.photoUrl,
        required this.federatedId,
        required this.email,
        required this.rawId,
        required this.screenName,
    });

    factory ProviderUserInfo.fromJson(Map<String, dynamic> json) => ProviderUserInfo(
        providerId: json["providerId"],
        displayName: json["displayName"],
        photoUrl: json["photoUrl"],
        federatedId: json["federatedId"],
        email: json["email"],
        rawId: json["rawId"],
        screenName: json["screenName"],
    );

    Map<String, dynamic> toJson() => {
        "providerId": providerId,
        "displayName": displayName,
        "photoUrl": photoUrl,
        "federatedId": federatedId,
        "email": email,
        "rawId": rawId,
        "screenName": screenName,
    };
}