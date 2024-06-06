import 'dart:convert';

import 'package:app_delivery/src/features/data/Repositories/DeliveryAddress/DeliveryAddressBodyParameters/delivery_address_body_parameters.dart';

class DeliveryAddressListEntity {
  final List<DeliveryAddressEntity> deliveryAddressList;

  DeliveryAddressListEntity({
    required this.deliveryAddressList,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'deliveryAddressList':
          deliveryAddressList.map((address) => address.toMap()).toList(),
    };
  }

  factory DeliveryAddressListEntity.fromMap(Map<String, dynamic> json) {
    return DeliveryAddressListEntity(
      deliveryAddressList: List<DeliveryAddressEntity>.from(
          json['deliveryAddressList']
              .map((address) => DeliveryAddressEntity.fromMap(address))),
    );
  }

  bool hasDeliveryAddress() {
    return deliveryAddressList.isNotEmpty;
  }

  DeliveryAddressListBodyParameters getDeliveryAddressBodyParameters() {
    return DeliveryAddressListBodyParameters.fromMap(toMap());
  }
}

class DeliveryAddressEntity {
  String id;
  double lat;
  double long;
  String street;
  String floorAndDoor;
  String city;
  String cp;
  String notes;
  String alias;

  DeliveryAddressEntity({
    required this.id,
    required this.lat,
    required this.long,
    required this.street,
    required this.floorAndDoor,
    required this.city,
    required this.cp,
    required this.notes,
    required this.alias,
  });

  bool isValidDeliveryAddress() {
    if (lat == 0.0 ||
        long == 0.0 ||
        street.isEmpty ||
        floorAndDoor.isEmpty ||
        city.isEmpty ||
        cp.isEmpty ||
        alias.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static DeliveryAddressEntity getEmptyDeliveryAddress() {
    return DeliveryAddressEntity(
        id: "",
        lat: 0.0,
        long: 0.0,
        street: "",
        floorAndDoor: "",
        city: "",
        cp: "",
        notes: "",
        alias: "Casa");
  }

  factory DeliveryAddressEntity.fromMap(Map<String, dynamic> json) =>
      DeliveryAddressEntity(
        id: json["id"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        street: json["street"],
        floorAndDoor: json["floor and door"],
        city: json["city"],
        cp: json["cp"],
        notes: json["notes"],
        alias: json["alias"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "lat": lat,
        "long": long,
        "street": street,
        "floor and door": floorAndDoor,
        "city": city,
        "cp": cp,
        "notes": notes,
        "alias": alias,
      };
}
