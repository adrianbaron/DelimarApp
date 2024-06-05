class UserBodyParameters {
  UserBodyParameters(
      {this.localId,
      this.role,
      this.username,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.startDate,
      this.photo,
      this.shippingAddress,
      this.billingAddress,
      this.idToken,
      this.provider});

  String? localId;
  String? role;
  String? username;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? startDate;
  String? photo;
  String? shippingAddress;
  String? billingAddress;
  String? idToken;
  String? provider;

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "username": username,
        "email": email,
        "phone": phone,
        "dateOfBirth": dateOfBirth,
        "startDate": startDate,
        "photo": photo,
        "shippingAddress": shippingAddress,
        "billingAddress": billingAddress,
        "idToken": idToken == null ? null : idToken,
        "provider": provider == null ? null : provider,

      };
}
