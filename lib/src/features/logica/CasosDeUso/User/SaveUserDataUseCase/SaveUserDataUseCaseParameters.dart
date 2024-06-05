import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
class SaveUserDataUseCaseParameters {
  SaveUserDataUseCaseParameters({
    this.localId,
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
    this.provider
  });

  String? localId;
  UserRole? role;
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

  SaveUserDataUseCaseParameters.fromUserEntity(UserEntity user) {
    localId = user.localId;
    role = UserRole.values.byName(user.role ?? "");
    username = user.username;
    email = user.email;
    phone = user.phone;
    dateOfBirth = user.dateOfBirth;
    startDate = user.startDate;
    photo = user.photo;
    shippingAddress = user.shippingAddress;
    billingAddress = user.billingAddress;
    idToken = user.idToken;
    provider = user.provider;
  }

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
    "idToken": billingAddress == null ? null : idToken,
    "provider": provider
  };
}