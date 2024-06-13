import 'dart:convert';

class DeliveryAddressListBodyParameters {
  final List<DeliveryAddressBodyParameters> deliveryAddressList;

  DeliveryAddressListBodyParameters({
    required this.deliveryAddressList,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'deliveryAddressList':
          deliveryAddressList.map((address) => address.toMap()).toList(),
    };
  }

  factory DeliveryAddressListBodyParameters.fromMap(Map<String, dynamic> json) {
    return DeliveryAddressListBodyParameters(
      deliveryAddressList: List<DeliveryAddressBodyParameters>.from(
          json['deliveryAddressList'].map(
              (address) => DeliveryAddressBodyParameters.fromMap(address))),
    );
  }

  static DeliveryAddressListBodyParameters getEmptyPaymentMethods() {
    return DeliveryAddressListBodyParameters(deliveryAddressList: []);
  }
}

class DeliveryAddressBodyParameters {
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

  DeliveryAddressBodyParameters(
      {required this.id,
      required this.lat,
      required this.long,
      required this.street,
      required this.floorAndDoor,
      required this.city,
      required this.cp,
      required this.notes,
      required this.alias,
      required this.isMainDeliveryAddress});

  factory DeliveryAddressBodyParameters.fromMap(Map<String, dynamic> json) =>
      DeliveryAddressBodyParameters(
          id: json["id"],
          lat: json["lat"]?.toDouble(),
          long: json["long"]?.toDouble(),
          street: json["street"],
          floorAndDoor: json["floorAndDoor"],
          city: json["city"],
          cp: json["cp"],
          notes: json["notes"],
          alias: json["alias"],
          isMainDeliveryAddress: json["isMainDeliveryAddress"]);

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
        "isMainDeliveryAddress": isMainDeliveryAddress
      };
}
