import 'dart:convert';

class PlaceListDecorable {
  PlaceListDecorable({
    required this.placeList,
  });
  List<PlaceList>? placeList;
  factory PlaceListDecorable.fromJson(String str) =>
      PlaceListDecorable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceListDecorable.fromMap(Map<String, dynamic> json) =>
      PlaceListDecorable(
        placeList: json["placeList"] == null
            ? null
            : List<PlaceList>.from(
                json["placeList"].map((x) => PlaceList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "placeList": placeList == null
            ? null
            : List<dynamic>.from(placeList!.map((x) => x.toMap())),
      };
}

class PlaceList {
  PlaceList({
    required this.address,
    required this.adminId,
    required this.averagePrice,
    required this.city,
    required this.collectionId,
    required this.country,
    required this.description,
    required this.email,
    required this.favourites,
    required this.hasAlcohol,
    required this.imgs,
    required this.lat,
    required this.long,
    required this.phoneNumber,
    required this.placeId,
    required this.placeName,
    required this.ratings,
    required this.ratingAverage,
    required this.zipCode,
    required this.status,
    required this.isPopularThisWeek,
    required this.isNovelty,
    required this.isOpenNow,
    required this.hasFreeDelivery,
  });

  final String address;
  final String adminId;
  final double averagePrice;
  final String city;
  final int collectionId;
  final String country;
  final String description;
  final String email;
  final List<String>? favourites;
  final bool hasAlcohol;
  final List<String>? imgs;
  final double lat;
  final double long;
  final String phoneNumber;
  final String placeId;
  final String placeName;
  final int ratings;
  final double ratingAverage;
  final String zipCode;
  final String status;
  final bool isPopularThisWeek;
  final bool isNovelty;
  final bool isOpenNow;
  final bool hasFreeDelivery;

  factory PlaceList.fromJson(String str) => PlaceList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceList.fromMap(Map<String, dynamic> json) => PlaceList(
      address: json["address"] == null ? null : json["address"],
      adminId: json["adminId"] == null ? null : json["adminId"],
      averagePrice: json["averagePrice"] == null ? null : json["averagePrice"],
      city: json["city"] == null ? null : json["city"],
      collectionId: json["collectionId"] == null ? null : json["collectionId"],
      country: json["country"] == null ? null : json["country"],
      description: json["description"] == null ? null : json["description"],
      email: json["email"] == null ? null : json["email"],
      favourites: json["favourites"] == null
          ? null
          : List<String>.from(json["favourites"].map((x) => x)),
      hasAlcohol: json["hasAlcohol"] == null ? null : json["hasAlcohol"],
      imgs: json["imgs"] == null
          ? null
          : List<String>.from(json["imgs"].map((x) => x)),
      lat: json["lat"] == null ? null : json["lat"].toDouble(),
      long: json["long"] == null ? null : json["long"].toDouble(),
      phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
      placeId: json["placeId"] == null ? null : json["placeId"],
      placeName: json["placeName"] == null ? null : json["placeName"],
      ratings: json["ratings"] == null ? null : json["ratings"],
      ratingAverage: json["ratingAverage"] == null
          ? null
          : json["ratingAverage"].toDouble(),
      zipCode: json["zipCode"] == null ? null : json["zipCode"],
      status: json["status"] == null ? null : json["status"],
      isPopularThisWeek:
          json["isPopularThisWeek"] == null ? null : json["isPopularThisWeek"],
      isNovelty: json["isNovelty"] == null ? null : json["isNovelty"],
      isOpenNow: json["isOpenNow"] == null ? null : json["isOpenNow"],
      hasFreeDelivery:
          json["hasFreeDelivery"] == null ? null : json["hasFreeDelivery"]);

  Map<String, dynamic> toMap() => {
        "address": address == null ? null : address,
        "adminId": adminId == null ? null : adminId,
        "city": city == null ? null : city,
        "collectionId": collectionId == null ? null : collectionId,
        "country": country == null ? null : country,
        "description": description == null ? null : description,
        "email": email == null ? null : email,
        "favourites": favourites == null
            ? null
            : List<dynamic>.from(favourites!.map((x) => x)),
        "imgs": imgs == null ? null : List<dynamic>.from(imgs!.map((x) => x)),
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "placeId": placeId == null ? null : placeId,
        "placeName": placeName == null ? null : placeName,
        "ratings": ratings == null ? null : ratings,
        "ratingAverage": ratingAverage == null ? null : ratingAverage,
        "zipCode": zipCode == null ? null : zipCode,
        "status": status == null ? null : status,
        "isPopularThisWeek":
            isPopularThisWeek == null ? null : isPopularThisWeek,
        "isNovelty": isNovelty == null ? null : isNovelty,
        "hasFreeDelivery": hasFreeDelivery == null ? null : hasFreeDelivery,
        "hasAlcohol": hasAlcohol == null ? null : hasAlcohol,
        "isOpenNow": isOpenNow == null ? null : isOpenNow,
        "averagePrice": averagePrice == null ? null : averagePrice,
      };
}
