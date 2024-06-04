import 'dart:convert';

UpdatePasswordDecorable updatePasswordDecorableFromJson(String str) => UpdatePasswordDecorable.fromJson(json.decode(str));

String updatePasswordDecorableToJson(UpdatePasswordDecorable data) => json.encode(data.toJson());

class UpdatePasswordDecorable {
    String kind;
    String email;

    UpdatePasswordDecorable({
        required this.kind,
        required this.email,
    });

    factory UpdatePasswordDecorable.fromJson(Map<String, dynamic> json) => UpdatePasswordDecorable(
        kind: json["kind"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "email": email,
    };
}