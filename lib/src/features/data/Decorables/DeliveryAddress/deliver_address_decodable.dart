import 'dart:convert';

class DeliveryAddressListDecodable {
  final List<DeliveryAddressDecodable> deliveryAddressList;

  DeliveryAddressListDecodable({
    required this.deliveryAddressList,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'deliveryAddressList':
          deliveryAddressList.map((address) => address.toMap()).toList(),
    };
  }

  factory DeliveryAddressListDecodable.fromMap(Map<String, dynamic> json) {
    return DeliveryAddressListDecodable(
      deliveryAddressList: List<DeliveryAddressDecodable>.from(
          json['deliveryAddressList']
              .map((address) => DeliveryAddressDecodable.fromMap(address))),
    );
  }

  static DeliveryAddressListDecodable getEmptyPaymentMethods() {
    return DeliveryAddressListDecodable(deliveryAddressList: []);
  }
}

class DeliveryAddressDecodable {
  String id;
  double lat;
  double long;
  String street;
  String floorAndDoor;
  String city;
  String cp;
  String notes;
  String alias;
  bool isMainDeliveryAddress;

  DeliveryAddressDecodable({
    required this.id,
    required this.lat,
    required this.long,
    required this.street,
    required this.floorAndDoor,
    required this.city,
    required this.cp,
    required this.notes,
    required this.alias,
    required this.isMainDeliveryAddress,
  });

  factory DeliveryAddressDecodable.fromMap(Map<String, dynamic> json) =>
      DeliveryAddressDecodable(
        id: json["id"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        street: json["street"],
        floorAndDoor: json["floorAndDoor"] ?? "",
        city: json["city"],
        cp: json["cp"],
        notes: json["notes"],
        alias: json["alias"],
        isMainDeliveryAddress: json["isMainDeliveryAddress"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "lat": lat,
        "long": long,
        "street": street,
        "floorAndDoor": floorAndDoor,
        "city": city,
        "cp": cp,
        "notes": notes,
        "alias": alias,
        "isMainDeliveryAddress": isMainDeliveryAddress,
      };
}
